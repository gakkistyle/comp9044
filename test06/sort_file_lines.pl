#!/usr/bin/perl -w

open $in,'<',$ARGV[0] or die "$!";

while($line = <$in>){
	chomp $line;
	$word_len{$line} = length($line);
}

@line_sorted = sort {$word_len{$a} <=> $word_len{$b} or $a cmp $b} keys %word_len;

for $line (@line_sorted){
	print "$line\n";
}