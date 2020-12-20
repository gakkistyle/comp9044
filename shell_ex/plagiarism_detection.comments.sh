#!/bin/sh

TMP_FILE1=/tmp/plagiarism_tmp1$$
TMP_FILE2=/tmp/plagiarism_tmp2$$

for file1 in "$@"
do
	for file2 in "$@"
	do
		if test "$file1" = "$file2"
		then
			break
		fi
		sed 's/\/\/.*//' "$file1" >$TMP_FILE1
		sed 's/\/\/.*//' "$file2" >$TMP_FILE2
		if diff -i -w $TMP_FILE2 $TMP_FILE1 >/dev/null
		then
			echo "$file1 is a copy of $file2"
		fi
	done
done
rm -f $TMP_FILE1 $TMP_FILE2
