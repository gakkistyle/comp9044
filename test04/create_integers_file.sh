#!/bin/sh
if test "$#" -ne 3
then
	exit 1;
fi

if test $1 -gt $2
then
	exit 1;
fi


start=$1;
end=$2;

filename=$3;
touch $filename;

while(test "$start" -le "$end")
do
    echo "$start" >> "$filename";
	start=$(($start + 1));
done