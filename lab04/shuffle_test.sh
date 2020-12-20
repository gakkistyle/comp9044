#!/bin/sh

max=120;
cnt=1000;

i=0;
num=1;
while test $i -lt $cnt;
do
	re=0;
	cat nums.txt | perl shuffle.pl >  "output$num.txt";
	for file in output*
	do
		if test "output$num.txt" != "$file" 
		then
			dif=`diff "output$num.txt" $file`;
			if [ "$dif" = "" ]
			then
				rm "output$num.txt";
				re=1;
				break;
			fi
		fi
	done
	if test $re -eq 0
	then
		num=$(($num + 1));
	fi
	i=$(($i + 1));
done

if test $num -eq 121
then
	flag=0;
	for file in output*
	do
		cat $file|sort > dd.txt;
		d=`diff dd.txt nums.txt`;
		if [ "$d" != "" ]
		then
			flag=1;
			echo "wrong,some files are not correct!";
			break;
		fi
	done
	if test $flag -eq 0
	then 
	    echo correct!;
	fi
else
	echo "wrong,the number does not match!";
fi

rm output*;


