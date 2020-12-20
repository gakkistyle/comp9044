#!/bin/sh

for file in *
do
	#if echo "$file"|egrep '^.*jpg$' >/dev/null

	if [[ "$file" =~ '^.*jpg$' ]]
	then
		#echo $file
		new_file=`echo $file|sed 's/jpg$/png/'`
		#echo $new_file
		if test -e "$new_file"
		then
			echo  "$new_file already exists"
			exit 1
		else
			convert "$file" "$new_file"
			rm "$file"
		fi
	fi

done
