#!/bin/bash

n=$1
m=$2

#set -x

i=$n
sum=0
while test $i -le $m
do
   sum=$((sum + i))
   i=$((i + 1))
done
echo "The integer $n..$m sum to $sum"
