#!/usr/bin/perl -w

while($line = <STDIN>){

	$line =~ /^[^\|]+\|([0-9]+)\|[^, ]+, ([^ ]+) .*$/;
	$zid = $1;
	$first_name = $2;

	$students{$zid} = $first_name;
}

if(exists %students){
	for $key (keys %students){
		push @fir_names,$students{$key};
	}
}

if(@fir_names){
	@sort_names = sort @fir_names;
}

for $names (@sort_names){
	print "$names\n";
}