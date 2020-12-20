#!/usr/bin/perl -w
$cnt = 0;
$dis_lin = 0;
while($line = <STDIN>){
	$cnt++;
	$line =~ tr/A-Z/a-z/ ;
	$line =~ s/ +//g ;
	$words{$line} ++;
	$dis_lin = scalar keys %words;
	if($dis_lin == $ARGV[0]){
		print "$ARGV[0] distinct lines seen after $cnt lines read.\n";
		exit 0;
	}
}

print "End of input reached after $cnt lines read - $ARGV[0] different lines not seen.\n";