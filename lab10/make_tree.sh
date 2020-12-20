#!/bin/sh

find $1|egrep Makefile|sed 's/\(.*\)\/Makefile/\1/'|
while read dir
do
	echo "Running make in $dir"
	if test $# -eq 1
	then
		make --no-print-directory -C $dir
	else
		make --no-print-directory $2 -C $dir
	fi
done