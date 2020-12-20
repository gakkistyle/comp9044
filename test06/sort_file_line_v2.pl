#!/usr/bin/perl -w

open my $in,'<',$ARGV[0] or die "$!";

@lines = <$in>;

@sorted_lines = sort {length $a <=> length $b or $a cmp $b} @lines;

print @sorted_lines;
