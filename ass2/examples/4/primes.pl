#!/usr/bin/perl -w

sub is_prime {
    my ($n, $i);
    $n = $_[0];
    $i = 2;
    while ($i < $n) {
        $n % $i == 0 and return 1;
        $i = $i + 1;
    }
    return 0;
}

$i = 0;
while ($i < 1000) {
    is_prime $i or print "$i\n";
    $i = $i + 1;
}
