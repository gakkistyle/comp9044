#!/usr/bin/perl -w

die "Usage: $0 <min> <max> <regex>\n" if @ARGV != 3;

($min, $max, $regex) = @ARGV;

die "regex too large" if length($regex) > 80;
print "regex is $regex\n";

foreach $n ($min..$max) {
    $unary = 1 x $n;
    print "$n = $unary unary - ";
    if ($unary =~ /^1?$|^(11+?)\1+$/) {
        print "composite\n";
        if($1){
            $hi = $1;
            print "hi $hi\n";
        }
    } else {
        print "prime\n";
    }
}
