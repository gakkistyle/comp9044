#!/usr/bin/perl -w

if($#ARGV == -1){
	print "Usage: ./identical_files.pl <files>\n";
	exit 1;
}

open my $IN,'<',$ARGV[0] or die "$!";
while($line = <$IN>){
	push @base,$line;
}
close($IN);
$i = 1;
while($i <= $#ARGV){
	open my $IN,'<',$ARGV[$i] or die "$!";
	$j = 0;
	while($line = <$IN>){
		if($line ne $base[$j]){
			print "$ARGV[$i] is not identical\n";
			close($IN);
			exit 1;
		}
		$j ++;
	}
	close($IN);
	$i ++;
}
print "All files are identical\n";