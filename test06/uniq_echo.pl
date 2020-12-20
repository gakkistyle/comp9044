#!/usr/bin/perl -w

for $word(@ARGV){
	if(!exists $words{$word}){
		$words{$word} = 1;
		push @words_list,$word;
	}
	else{
		next;
	}
}

print "@words_list\n";

