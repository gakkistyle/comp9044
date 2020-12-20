#!/usr/bin/perl -w

my $total = 0;

while($line = <STDIN>){
	@words = $line =~ /[a-zA-Z]+/g;
	$total += scalar @words;
}

print "$total words\n";