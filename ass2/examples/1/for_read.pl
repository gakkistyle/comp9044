#!/usr/bin/perl -w

foreach $n ('one', 'two', 'three') {
    $line = <STDIN>;
    chomp $line;
    print "Line $n $line\n";
}
