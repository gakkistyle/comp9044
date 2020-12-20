#!/bin/bash

#set -x

#while ls fred.c 2>/dev/null
i=1
while test $i -lt 11
do
  echo $i
  sleep 1
  i=$((i + 1))
done
echo finished

while test -r cat.c
do
    echo cat.c is still there
    sleep 2
done
echo danger!
