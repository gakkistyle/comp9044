#!/usr/bin/perl -w

if($#ARGV != 2 || $ARGV[0] > $ARGV[1]){
	exit 1;
}

$start = $ARGV[0];
$end = $ARGV[1];
$filename = $ARGV[2];

open $file,'>',$filename or die $!;
while($start <= $end){
	print $file "$start\n";
    $start++;
}

close("$file");