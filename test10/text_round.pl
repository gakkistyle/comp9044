#!/usr/bin/perl -w

while($line = <STDIN>){
	chomp $line;
	while($line =~ /(([0-9]+)\.[5-9][0-9]*)/)
	{
		$num = $1;
		$round_num = $2;
		$round_num ++;
		$line =~ s/$num/$round_num/;
	}
	while($line =~ /(([0-9]+)\.[0-4][0-9]*)/){
		$num = $1;
		$round_num = $2;
		$line =~ s/$num/$round_num/;
	}
	print "$line\n";
}