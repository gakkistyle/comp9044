#!/usr/bin/perl -w

@words = ();
$can_apppend = 1;
foreach $word(@ARGV){
	foreach $w(@words){
		if($w eq $word){
			$can_apppend = 0;
			last;
		}
	}
	if($can_apppend == 1){
		push @words,$word;
	}else{
		$can_apppend = 1;
	}
}


print "@words\n";