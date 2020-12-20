#!/usr/bin/perl -w

# this is from lector notes repeat_message.sh
# written by andrewt@cse.unsw.edu.au as a COMP2041|COMP9044 example
# demonstrate simple use ofa shell function

sub repeat_message {
    $n = $_[0];
    $message = $_[1];
    my ($i);
    $i = 0;
    while ($i < $n) {
        print "$i: $message\n";
        $i = $i + 1;
    }
}

$i = 0;
while ($i < 4) {
    repeat_message 3, "helloAndrew" ;
    $i = $i + 1;
}
