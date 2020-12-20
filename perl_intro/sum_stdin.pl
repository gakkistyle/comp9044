#!/bin/perl

$sum = 0;
while($line = <STDIN>){
	$line =~ s/^\s*//;
	$line =~ s/\s*$//;

	if($line !~ /^\d[.\d]*$/){
		last;
	}
    $sum += $line;
}
print "Sum of the numbers is $sum\n";