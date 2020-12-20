#!/usr/bin/env dash

#check .shrug exists
if ! test -d .shrug/
then
    echo "shrug-commit: error: no .shrug directory containing shrug repository exists";
    exit 1;
fi

now_branch=`cat .shrug/now_branch`;
#flag_re test if repo exists,flag_log check if log exists,and flag_index check if index exists.
flag_log=0;
flag_index=0;

#if index not exists in .shrug/,then fail to run.
if ! test -d ".shrug/branch/$now_branch/index" 
then
    echo "nothing added to commit but untracked files present";
    exit 1;
fi



#-a option
if test "$1" = "-a"
then
    for file in .shrug/branch/$now_branch/index/*
    do
        file_=`echo "$file"|cut -d'/' -f5`;
        contain=`ls $file_ 2>/dev/null`;
        if test "$contain" != ""
        then
            cp "$file_" "$file" ;
        else
            rm "$file";
        fi
    done
fi

#test for if there is change after the last repo.If no change,we do not commit anything.
change=0;
num=`ls -c .shrug/repo|wc -l|sed 's/ //g'`;
if test $num -eq 0
then
    change=1;
else
    #latest=$(($num - 1));
    latest_branch=`ls .shrug/branch/$now_branch/repo|sort -r|head -n1`;
    #need to check if index and latest repo contain same number of files.
    index_file_c=`ls .shrug/branch/$now_branch/index/ |wc -l`;
    #repo_file_c=`ls .shrug/repo/$latest|wc -l`;
    repo_branch_file_c=`ls .shrug/branch/$now_branch/repo/$latest_branch|wc -l`
    if test "$index_file_c" -ne "$repo_branch_file_c"
    then
        change=1;
    else
        if test $index_file_c -eq 0 &&  test $repo_branch_file_c -eq 0
        then
            echo "nothing to commit";
            exit 1;
        fi
        for file in .shrug/branch/$now_branch/index/*
        do
            filename=`echo $file|cut -d'/' -f5`;
            contain=`ls .shrug/branch/$now_branch/repo/$latest_branch/$filename 2>/dev/null`;
            if test "$contain" != ""
            then
                dif_now_repo=`diff $file .shrug/branch/$now_branch/repo/$latest_branch/$filename|wc -w`;
                if test $dif_now_repo -gt 0
                then
                    change=1;
                    break;
                fi
            else
                change=1;
                break;
            fi
        done
    fi
fi

if test $change -eq 0
then
    echo "nothing to commit";
    exit 1;
fi

mkdir ".shrug/repo/$num";
mkdir ".shrug/branch/$now_branch/repo/$num";

has_file=`ls .shrug/branch/$now_branch/index|wc -l|sed 's/ //g'`;
if test $has_file -gt 0
then
    cp .shrug/branch/$now_branch/index/*  .shrug/repo/$num/ ;
    cp .shrug/branch/$now_branch/index/*  .shrug/branch/$now_branch/repo/$num/ ;
fi
echo "Committed as commit $num";

if test $# -eq 4
then
    mess=$3;
else
    mess=$2;
fi

#the following two shows if  log do not exist,create a new one.
if ! test -e ".shrug/branch/$now_branch/log" 
then
    touch .shrug/branch/$now_branch/log;
fi
echo "$num $mess" >> .shrug/branch/$now_branch/log;
