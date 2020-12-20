#!/bin/perl -w

die "Usage: cp <source> <destination>\n" if @ARGV != 2;

$infile = $ARGV[0];
$outfile = $ARGV[1];

open my $in, '<', $infile or
    die "$0: open of $infile failed: $!\n";

open my $out, '>', $outfile or
    die "$0: open of $outfile failed: $!\n";

@lines = <$in>;
print $out @lines;

close $out;
close $in;
exit 0;