#!/usr/bin/env dash

#check .shrug exists
if ! test -d .shrug/
then
    echo "shrug-show: error: no .shrug directory containing shrug repository exists";
    exit 1;
fi

#test for format num:repo
content=$1;
match=`echo $1|egrep '^[0-9]*:.+'`;
if test "$match" = ""
then
    echo "shrug-show: error: invalid object $1";
    exit 1;
fi

#get the number before : and fileaname after :.
num=`echo $1|sed 's/:.*$//g'`;
filename=`echo $1|sed 's/^.*://g'`;

#test if the required num beyond maximum repo num
max_num=`ls -c .shrug/repo|wc -l|sed 's/ //g'`;
max_repo=$(($max_num - 1));
now_branch=`cat .shrug/now_branch`;
#whatever num is "" or a number,we all should test if the file does exist in index or repo we ask for.
if test "$num" = ""
then
    contain=`ls .shrug/branch/$now_branch/index/$filename 2>/dev/null`;
    if test "$contain" != ""
    then
        cat ".shrug/branch/$now_branch/index/$filename";
    else
        echo "shrug-show: error: '$filename' not found in index";
    fi
else
    if test $num -gt $max_repo
    then
        echo "shrug-show: error: unknown commit '$num'";
        exit 1;
    else
        contain=`ls .shrug/repo/$num/$filename 2>/dev/null`;
        if test "$contain" != ""
        then
            cat ".shrug/repo/$num/$filename";
        else
            echo "shrug-show: error: '$filename' not found in commit $num";
        fi
    fi
fi
