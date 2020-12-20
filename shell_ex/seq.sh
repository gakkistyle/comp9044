#!/bin/bash
if test $# = 1
then
    last=$1
    first=1
    inc=1
elif test $# = 2
then
    last=$2
    first=$1
    inc=1
elif test $# = 3
then
    last=$3
    first=$1
    inc=$2
else
    echo "Error: wrong number of arguments"
    exit 1
fi

while test $first -le $last
do
    echo "$first"
    first=`expr $first + $inc`
done
