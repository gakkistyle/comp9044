#!/usr/bin/perl -w

sub print_odd{
	my ($selector,@list) = @_;

	foreach (@list){
		print "$_¥n" if &$selector;
	}
}

@numbers = (1 .. 10);

print_odd sub {$_ > 5}, @numbers;