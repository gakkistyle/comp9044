#!/usr/bin/perl -w
opendir(DIR,$ARGV[0]);
@files = readdir(DIR);
closedir DIR;

foreach $key (@files){
	if(-d "$ARGV[0]//$key"){
		print "$key\n";
	}
}