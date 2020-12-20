#!/usr/bin/perl -w
# l [file|directories...] - list files
# written by andrewt@cse.unsw.edu.au as a COMP2041 example

system "ls -las @ARGV";
exit 0;
