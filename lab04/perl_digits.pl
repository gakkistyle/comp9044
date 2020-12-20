#!/bin/perl

while($word = <STDIN>){
	$word =~ s/[0-4]/</g;
	$word =~ s/[6-9]/>/g;
	print $word;
}