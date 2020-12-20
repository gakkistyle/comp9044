#!/bin/sh

for file in *
do
	end=`echo $file|egrep -o 'htm.*$'`
	if test "$end" = "htm"
	then
		newfile="$file""l"
		if test -f "$newfile"
		then
			echo "$newfile exists"
			exit 1
		fi
		cp "$file" "$newfile"
		rm "$file"

	fi

done