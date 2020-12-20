#!/usr/bin/perl -w

$word = $ARGV[0];

@files = glob "lyrics/*.txt";


for $file (@files){
	open my $in,'<',$file or die "$!";

	$file =~ s/^[a-z]*\///ig;
	$file =~ s/\.txt//g;
	$file =~ s/_/ /g;
	$art = $file;
	$totalwords = 0;
	$count = 0;
	while($line = <$in>){
		 @words = $line =~ /[a-zA-Z]+/g;
		 $totalwords += @words;
		@line = split /[^a-z]+/i,$line;
		
		for $w (@line){
			if ($word =~ m/^$w$/i){
				$count ++;
			}
		}
	}
	printf "%4d/%6d = %.9f %s\n", $count, $totalwords, $count/$totalwords,$art;
}