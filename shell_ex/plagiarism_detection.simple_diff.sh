#!/bin/sh

for file1 in "$@"
do
	for file2 in "$@"
	do
		test "$file1" = "$file2" && break
		if diff -i -w "$file1" "$file2" >/dev/null
		then
			echo "$file1 is a copy of $file2"
		fi
	done
done