#!/bin/sh

for image in "$@"
do
	display $image
	echo -n "Address to e-mail this image to? "
	read add
	echo -n "Message to accompany image? "
	read m
    fileName=`echo "$file" | cut -d"." -f1`
    topic="$fileName""!"
	echo "$m" | mutt -s "$topic" -e 'set copy=no' -a "$image" -- "$add"
	echo "$image sent to $add"
done
