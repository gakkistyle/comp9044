#!/usr/bin/perl -w

use File::Compare;
for $i (glob "$ARGV[0]/*"){
	$file=$i=~s|.*\/||gr;
	if(compare($i,"$ARGV[1]/$file")==0){    #equal file
		print "$file\n";
	}
}