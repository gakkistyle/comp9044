#!/bin/perl -w

while ($line = <STDIN>){
	push @lines, $line;
}

print @lines;
# while (@lines){
# 	$line = pop @lines;
# 	print $line;
# }

open my $f, "-|","date";
$date = <$f>;
print "Date is $date";
