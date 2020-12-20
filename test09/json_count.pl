#!/usr/bin/perl -w

open $in,'<',"$ARGV[1]" or die "#!";

$target = $ARGV[0];
$this_cnt = 0;
$sum = 0;
while ($line = <$in>){
	if($line =~ /^ *\"how_many\": ([0-9]*),/){
		$this_cnt = $1;
	}
	if($line =~ /^ *\"species\": \"$target\"/){
		$sum += $this_cnt;
	}
}
print "$sum\n";