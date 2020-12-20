#!/bin/sh

filename="$1";
num=0;
cp_name=".$filename.$num";
contain=`ls $cp_name 2>/dev/null`;
while test "$contain" != ""
do
	num=$(($num + 1));
	cp_name=".$filename.$num";
	contain=`ls $cp_name 2>/dev/null`;
done

cp $filename $cp_name;
echo "Backup of '$filename' saved as '$cp_name'";