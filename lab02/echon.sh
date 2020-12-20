#!/bin/sh

if test $# -ne 2
then
	echo "Usage: $0 <number of lines> <string>"
elif test "$1" -ge 0 2>/dev/null
then
	inc=0
	while test $inc -lt $1
    do 
	    inc=$(($inc + 1))
	    echo $2
	done
else
	echo "$0: argument 1 must be a non-negative integer"
fi
	#statements
