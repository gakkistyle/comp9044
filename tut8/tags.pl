#!/usr/bin/perl -w

$url = shift @ARGV ;
$webpage = `wget -q -O- '$url'`;
$webpage =~ tr/A-Z/a-z/;

$webpage =~ s/<![^>]*>//g;
@tags = $webpage =~ /<\s*([a-z]+)[^>]*>/g;

foreach $tag (@tags){
	$hashtag{$tag}++;
}

@taglist = (sort keys %hashtag);

foreach $tag (@taglist){
	print ("$tag $hashtag{$tag}\n");
}