#!/usr/bin/perl -w

sub grep_selected ($@){
	my ($selector,@list) = @_;

	my @new_list;
	foreach (@list){
		#print "$_\n" if &$selector;
		push @new_list, $_ if &$selector;
	}
	return @new_list;
}

@numbers = (1 .. 10);

@odd =  grep_selected sub {$_ %2 == 1}, @numbers;
#print_odd sub {$_ >2}, @numbers;

print join("\n",@odd),"\n";