#!/bin/sh


for file in $1/*
do
    echo $file;
    # filename=`echo "$file"|sed 's|.*\/||g'`;
    # if test -e "$2/$filename"
    # then
    #     is_dif=`diff $file $2/$filename|wc -l`;
    #     if test $is_dif -eq 0
    #     then
    #         echo $filename;
    #     fi
    # fi
done
