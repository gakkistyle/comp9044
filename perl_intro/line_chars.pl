#!/bin/perl

printf "Enter some input: ";
$line = <STDIN>;

if(!defined $line){
	die "$0: could not read any characters\n";
}
chomp $line;
$n_chars = length $line;
print "That line contained $n_chars characters\n";

if($n_chars>0){
	$first_char = substr($line,0,1);
	$last_char = substr($line,$n_chars - 1,1);
	print "The first character was '$first_char'\n";
	print "The last character was '$last_char'\n";
}