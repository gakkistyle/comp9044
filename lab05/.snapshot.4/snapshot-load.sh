#!/bin/dash

back_num=$1;

./snapshot-save.sh

echo "Restoring snapshot $back_num";
for file in *
do
	if test "$file" != "snapshot-save.sh" && test "$file" != "snapshot-load.sh"
	then
		rm $file;
	fi
done

for file in .snapshot.$back_num/*
do
	cp $file . ;
done

