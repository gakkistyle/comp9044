#!/usr/bin/perl -w


my $total = 0;
my $word = $ARGV[0];

while($line = <STDIN>){
	@line = split /[^a-z]+/i,$line;
	for $w (@line){
		if ($word =~ m/^$w$/i){
			$total ++;
		}
	}
}

print "$word occurred $total times\n";