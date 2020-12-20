#!/bin/dash

num=0;
dirname=".snapshot.$num";

while test -e $dirname
do
	num=$(($num + 1));
	dirname=".snapshot.$num";
done

mkdir $dirname;

for file in *
do
	if test "$file" != "snapshot-save.sh" && test "$file" != "snapshot-load.sh"
	then	
			cp $file $dirname;
	fi
done

echo "Creating snapshot $num";