#!/usr/bin/perl -w
#this demo is from lab2 echon.sh


if ($#ARGV+1 != 2) {
	print "Usage: $0 <number of lines> <string>\n";
} elsif ($ARGV[0] >= 0) {
	$inc = 0;
	while ($inc < $ARGV[0]) {
	    $inc = $inc + 1;
	    print "$ARGV[1]\n";
	}
} else {
	print "$0: argument 1 must be a non-negative integer\n";
}
	#statements;
