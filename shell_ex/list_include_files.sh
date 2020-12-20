#!/bin/bash
for file in c_files/*.c
do 
     echo "$file includes:"
     egrep "^#.*\.h$" "$file"|cut -d' ' -f2
done
