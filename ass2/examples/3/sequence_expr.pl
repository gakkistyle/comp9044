#!/usr/bin/perl -w
# print a contiguous integer sequence
$start = $ARGV[0];
$finish = $ARGV[1];

$number = $start;
while ($number <= $finish) {
    print "$number\n";
    $number = $number + 1;  # increment number
}
