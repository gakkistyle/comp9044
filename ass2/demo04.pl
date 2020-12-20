#!/usr/bin/perl -w

$num = $ARGV[0];

while ($num > 0) {
	$num = $num - 2 ;
}

if ($num == -1) {
	print "$ARGV[0] is odd\n";
} else {
	print "$ARGV[0] is even\n";
}
