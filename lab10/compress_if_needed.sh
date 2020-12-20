#!/bin/sh

for file in $@
do
	ori_size=`ls -l $file|cut -d' ' -f5`
	xz $file
	xz_size=`ls -l "$file.xz"|cut -d' ' -f5`
	if test $xz_size -ge $ori_size
	then
		echo "$file $ori_size bytes, compresses to $xz_size bytes, left uncompressed"
		unxz "$file.xz"
	else
		echo "$file $ori_size bytes, compresses to $xz_size bytes, compressed"
	fi
done
