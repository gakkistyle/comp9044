#!/usr/bin/perl -w

@print_vowels = ();

for $word(@ARGV){
	if ($word =~/[aeiou]{3}/gi){
		push @print_vowels,$word;
	}
}

print "@print_vowels\n";