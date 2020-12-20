#!/usr/bin/perl -w
# writen by andrewt@cse.unsw.edu.au as a COMP2041 example
# compute Pythagoras' Theorem

print "Enter x: ";
$x = <STDIN>;
chomp $x;
print "Enter y: ";
$y = <STDIN>;
chomp $y;
$pythagoras = sqrt $x * $x + $y * $y;
print "The square root of $x squared plus $y squared is $pythagoras\n";