#!/bin/bash

for id in `cat Students.txt|cut -d' ' -f1`
do
    name=`egrep "$id" Students.txt | cut -d' ' -f2$`
    mark=`egrep "$id" Marks.txt | cut -d' ' -f2`
    echo "$mark $name"
done
