#!/bin/sh

#this on is from tutorial question primes.sh
# test whether the specified integer is prime
# written by Han Zhao

if test $# -ne 1
then
    echo "Usage: $0 <number>"
    exit 1
fi

n=$1
if test $1 -eq 1
then
    echo "$n is not prime"
    exit 1
fi

i=2
while test $(expr $i '*' $i) -le $n
do
    if test `expr $n % $i` -eq 0
    then
        echo "$n is not prime"
        exit 1
    fi
    i=`expr $i + 1`
done
echo "$n is prime"
exit 0