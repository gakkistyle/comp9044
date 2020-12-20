#!/usr/bin/perl -w

while($line = <STDIN>){
	chomp $line;
	@words = split /\s+/ , $line;
	@result = sort @words;
	print "@result\n";
}