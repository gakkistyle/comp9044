#!/bin/sh

for image in "$@"
do
	time=`ls -l $image|cut -d' ' -f6-8`
	convert -gravity south -pointsize 36 -draw "text 0,10 "$time"" "$image" "$image"
done