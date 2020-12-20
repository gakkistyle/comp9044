#!/usr/bin/perl -w

@lines = <>;

@matching_lines = grep {$_ =~ /Herminoe/i} @lines;

print @matching_lines;