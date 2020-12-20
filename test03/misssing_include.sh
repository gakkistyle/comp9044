#!/bin/sh

for file in "$@"
do
	cat "$file"|egrep '^#include ".*"'|
	while read line
	do
		includer=`echo $line|cut -d'"' -f2`
		if ! test -f "$includer"
		then
			echo "$includer included into $file does not exist"
		fi
	done
done