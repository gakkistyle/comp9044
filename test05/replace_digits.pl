#!/usr/bin/perl -w

open my $IN,'<',$ARGV[0] or die "$!";
while($line = <$IN>){
	$line =~ s/\d/#/g;
	push @contents,$line;
}
close($IN);

open my $OUT,'>',$ARGV[0] or die "$!";
foreach $line(@contents){
	print $OUT "$line";
}
close($OUT);