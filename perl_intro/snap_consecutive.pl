#!/bin/perl

print "Enter line: ";
$last_line = <STDIN>;
print "Enter line: ";
while ($line = <STDIN>){
	if ($line eq $last_line){
		print "Snap!\n"
	}
	$last_line = $line;
	print "Enter line: ";
}