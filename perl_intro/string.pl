#!/bin/perl -w

$string = "Hi Perl ";
$i = 0;
while ($i < 30){
	$string = "$string$string"; #string cancate
	$i++;
}

print $string;