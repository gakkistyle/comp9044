#!/usr/bin/perl -w
for $file (glob "lyrics/*.txt"){
                $author_prob{$file}=0;
               	$total_words{$file}=0;
}

for $author (glob "lyrics/*.txt"){
    open $f,'<',"$author" or die "cant open";
    for $line (<$f>){
    	chomp $line;
	if ($line =~ /^\s*$/){
		next;
	}
	$line =~ s/^[^a-z]+//gi;
	@line = split /[^a-z]+/i,$line;
	for $word (@line){
		if($word eq ''){
			next;
		}
		$word=~tr/A-Z/a-z/;		
		$singer_lyrics{$author}{$word}++;
		$total_words{$author}++;
	}
    }
    close $f;
}

@list_file=sort @ARGV;

for $file (@list_file){
    open $f,'<',"$file" or die 'cant open';     # file='song0.txt'
 
    for $line (<$f>){
        if ($line =~ /^\s*$/){
            next;
        }
        $line =~ s/^[^a-z]+//gi;
	@line = split /[^a-z]+/i,$line;      
      
        foreach $word (@line){
		$word=~tr/A-Z/a-z/;
        	for $author (keys %total_words){
		    	if (exists($singer_lyrics{$author}{$word})){
		    		$occur=$singer_lyrics{$author}{$word};
		    		$author_prob{$author}+=log(($occur+1)/$total_words{$author});
		    	
			}
			else{
				$occur=0;
		    		$author_prob{$author}+=log(($occur+1)/$total_words{$author});
			}
		}
    	}
    }
    close $f;
    @authors=sort {$author_prob{$a}<=>$author_prob{$b}} keys %author_prob;
    $max_author=pop @authors;
    $author=$max_author;
    $author=~s/lyrics\///;
    $author=~s/.txt$//;
    $author=~s/_/ /g;
    printf "%s most resembles the work of %s (log-probability=%4.1f)\n", $file, $author, $author_prob{$max_author};
    for $author (keys %author_prob){
    	$author_prob{$author}=0;
    }
}