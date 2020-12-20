#!/usr/bin/perl -w
$start = 13;
if (@ARGV > 0) {
    $start = $ARGV[0];
}
$i = 0;
$number = $start;
$file = './tmp.numbers';
system "rm -f $file";
while (1) {
    if (-r $file) {
        if (! system "fgrep -x -q $number $file") {
            print "Terminating because series is repeating\n";
            exit 0;
        }
    }
    open F, '>>', $file or die;
    print F "$number\n";
    close F;
    print "$i $number\n";
    $k = $number % 2;
    if ($k == 1) {
        $number = 7 * $number + 3;
    } else {
        $number = $number / 2;
    }
    $i = $i + 1;
    if ($number > 100000000 || $number < -100000000) {
        print "Terminating because series has become too large\n";
        exit 0;
    }
}
system "rm -f $file";
