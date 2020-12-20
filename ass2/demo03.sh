#!/bin/dash

#test read line during while loop

while read line
do
	if test "$line" \< "zibra"
	then
		echo "this is a word smaller than zibra"
	else
		echo a really big word, then let us end
		exit 0
	fi
done