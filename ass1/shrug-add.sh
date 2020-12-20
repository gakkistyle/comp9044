#!/usr/bin/env dash

#check .shrug exists
if ! test -d .shrug/
then
    echo "shrug-add: error: no .shrug directory containing shrug repository exists" >/dev/stderr;
    exit 1;
fi

#check if the filename valid or not
for file in "$@"
do
    match=`echo $file|grep '^[a-zA-Z0-9][a-zA-Z0-9\.\-\_]*$'`;
    if test "$match" = ""
    then
        echo "shrug-add: error: invalid filename '$file'" >/dev/stderr;
        exit 1;
    fi
done

now_branch=`cat .shrug/now_branch`;

#check if all filenames in the current dir or in the index
for file in "$@"
do
    contain_cur=`ls $file 2>/dev/null`;
    contain_in=`ls .shrug/branch/$now_branch/index/$file 2>/dev/null`;
    if test "$contain_cur" = "" && test "$contain_in" = ""
    then
        echo "shrug-add: error: can not open '$file'" > /dev/stderr;
        exit 1;
    fi
done

for file in "$@"
do
    contain_cur=`ls $file 2>/dev/null`;
    if test "$contain_cur" != ""
    then
        cp "$file"  .shrug/branch/$now_branch/index/ ;
    else
        rm ".shrug/branch/$now_branch/index/$file";
    fi
done
