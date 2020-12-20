#!/usr/bin/perl -w

while($line1 = <STDIN>){
	chomp $line1;
	push @lines,$line1;
	
}

foreach $line2(@lines){
	if($line2 =~ /^ *\#([0-9]+) *$/){
		$tar_num = $1;
		$tar_line = $lines[$tar_num -1];
		$line2 =~ s/#([0-9]+)/$tar_line/ ;
	}
	print "$line2\n";
}