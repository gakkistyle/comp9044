#!/bin/dash

max=$1
min=$1
for num in $@
do
	if test $num -gt $max
	then
		max=$num
	fi
	if test $num -lt $min
	then
		min=$num
	fi

done

for find_num in $(seq $min $max)
do
	ok=0
	for tar in $@
	do
		if test $tar -eq $find_num
		then
			ok=1
			break
		fi
	done

	if test $ok -eq 0
	then
		echo $find_num
		exit 0;
	fi
done