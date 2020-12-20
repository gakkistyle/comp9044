#!/usr/bin/perl -w

open $in,'<',$ARGV[0] or die "$!";

while($line = <$in>){
	chomp $line;
	push @lines,$line;
}


$num_l = @lines;

if($num_l % 2 == 1){
	print "$lines[$num_l/2]\n";
}elsif($num_l % 2 == 0 && $num_l > 0){
	print "$lines[$num_l/2 - 1]\n$lines[$num_l/2]\n";

}
close($in);