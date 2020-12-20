#!/usr/bin/perl -w
foreach $c_file (glob("*.c")) {
    print "gcc -c $c_file\n";
}
