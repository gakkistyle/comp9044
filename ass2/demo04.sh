#!/bin/sh

num=$1

while [  $num -gt 0 ]
do
	num=$(expr $num - 2)
done

if test $num -eq -1
then
	echo $1 is odd
else
	echo $1 is even
fi