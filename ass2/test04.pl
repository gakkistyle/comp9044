#!/usr/bin/perl -w

$sum = 0;

foreach $num (@ARGV) {
	$sum = $sum + $num;
}

print "the sum is $sum\n";
