#!/usr/bin/perl -w

$operation = shift @ARGV;

foreach $filename (@ARGV){
	$_ = $filename;
	eval $operation;
	$new_filename = $_;
	next if $new_filename eq $filename;
	die "$new_filename exists\n" if -e $new_filename;
	rename $filename,$new_filename;
}