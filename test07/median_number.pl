#!/usr/bin/perl -w

@all_nums = sort {$a <=> $b} @ARGV;
$nums = scalar @all_nums;

print "$all_nums[$nums/2]\n";