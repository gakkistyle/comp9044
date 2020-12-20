#!/usr/bin/perl -w

while($line = <STDIN>){
	$line =~ /^[^\|]+\|([0-9]+)\|[^, ]+, ([^ ]+) .*$/;
	$zid = $1;
	$zid_record{$zid}++;
}

if(%zid_record){
	for $key (keys %zid_record){
		if($zid_record{$key} == 2){
			push @id_2,$key;
		}
	}
}

if(@id_2){
	@sorted_id = sort {$a <=> $b} @id_2;
	for $id (@sorted_id){
		print "$id\n";
	}
}