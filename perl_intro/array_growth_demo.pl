#!/bin/perl

while(1){
	print "Enter array index: ";
	$n = <STDIN>;
	if ($n !~ /^\d$/){
		last;
	}
	chomp $n;
	$a[$n] = 42;
	print "Array element $n now contains $a[$n]\n";
	printf "Array size is now %d\n",$#a+1;
}