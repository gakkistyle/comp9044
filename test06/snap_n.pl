#!/usr/bin/perl -w

$time = 0;
while($line = <STDIN>){
	$lines{$line}++;
	if($lines{$line} == $ARGV[0] && $time == 0){
		$time = 1;
		$output = $line;
	}
}

if($output){
	print "Snap: $output\n";
}