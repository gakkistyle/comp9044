#!/usr/bin/perl -w

$s = join(",", 1..5);

@a = split(",",$s);
print "@a\n";

@a = split("[,;:]+","2,,,4;;;8:::16");
print "@a\n";