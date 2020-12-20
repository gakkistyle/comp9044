#!/bin/dash
# print a contiguous integer sequence
start=$1
finish=$2

number=$start
while test $number -le $finish
do
    echo $number
    number=$((number + 1))  # increment number
done
