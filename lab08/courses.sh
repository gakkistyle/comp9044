#!/bin/sh 

url="http://timetable.unsw.edu.au/2020/$1KENS.html";

curl --location --silent $url|sort|uniq|
while read line
do
    match=`echo $line|egrep "^ *<td class=\"data\">.*\"$1[0-9]*.*\">.*</a></td>"|egrep -v ".*$1[0-9]*.*$1[0-9]*"`;
	if test "$match" != ""
	then
		
		output=`echo $match|sed -e "s/^ *<td class=\"data\">.*\"\($1[0-9]*\)\.html.*\">\(.*\)<\/a><\/td>/\1 \2/g"`;
		echo $output;
	fi

done
