#!/usr/bin/perl -w

$regex = shift @ARGV;
print grep {/$regex/i} <>;