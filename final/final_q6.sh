#!/bin/dash

ok=0;

i=1;
line=""
for file1 in "$@"
do
	this=0;
	for file2 in "$@"
	do
		if test $this -lt $i
		then
			this=`expr $this + 1`
		else
			test_diff=`diff "$file1" "$file2"|wc -l`
			if test $test_diff -eq 0
			then
				ok=1;
				ok_echo=`echo "$line"|egrep "$file1 $file2"`
				if test "$ok_echo" = ""
				then
					echo "ln -s $file1 $file2"
					line="$line ""$file1 $file2"
				fi
			fi
		fi
	done
	line="$line "
	i=`expr $i + 1`
done


if test $ok -eq 0
then
	echo "No files can be replaced by symbolic links";
	exit 0;
fi