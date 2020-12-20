#!/bin/perl -w

$filename = $ARGV[0];

$num = 0;
$cpname = ".$filename.$num";
while(-e "$cpname"){
	$num ++;
	$cpname = ".$filename.$num";
}

open my $in,'<',"$filename" or die "$!";
open my $out,'>' ,"$cpname" or die "$!";

while($line = <$in>){
	print $out "$line";
}

print "Backup of '$filename' saved as '$cpname'\n";
close $in;
close $out;