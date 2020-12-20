#!/bin/sh

for file in *.htm
do
    file_after="$file""l"
    if test -e "$file_after"
    then
        echo "$file_after" exists
        exit 1
    fi
    
    mv "$file" "$file_after"
    
done
