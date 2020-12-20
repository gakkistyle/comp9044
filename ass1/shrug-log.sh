#!/usr/bin/env dash

#check .shrug exists
if ! test -d .shrug/
then
    echo "shrug-add: error: no .shrug directory containing shrug repository exists";
    exit 1;
fi

#check .shrug/log exists
now_branch=`cat .shrug/now_branch`;
if ! test -e  .shrug/branch/$now_branch/log
then
    echo "shrug-log: error: your repository does not have any commits yet";
    exit 1;
fi


tac .shrug/branch/$now_branch/log;
