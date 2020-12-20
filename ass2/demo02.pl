#!/usr/bin/perl -w

#this on is from tutorial question primes.sh
# test whether the specified integer is prime
# written by Han Zhao

if ($#ARGV+1 != 1) {
    print "Usage: $0 <number>\n";
    exit 1;
}

$n = $ARGV[0];
if ($ARGV[0] == 1) {
    print "$n is not prime\n";
    exit 1;
}

$i = 2;
while ($i * $i <= $n) {
    if ($n % $i == 0) {
        print "$n is not prime\n";
        exit 1;
    }
    $i = $i + 1;
}
print "$n is prime\n";
exit 0;
