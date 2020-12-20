#!/usr/bin/perl -w

while($line = <STDIN>){
	@words = split(/\s+/,$line);
	@ok_words = ();
	for $word (@words){
		$std_num=0;
		$word_ch = lc $word;
		@single_c = split(//,$word_ch);
		%c_num = ();
		for $c (@single_c){
			#print "$c\n";
			$c_num{$c}++;
		}
		$ok=1;
		if(%c_num){
			for $key (keys %c_num){
				$this_count = $c_num{$key};
				#print "$word $key $this_count\n";
				if(!$std_num){
					$std_num = $this_count;
				}else{
					if($std_num != $this_count){
						#print "$word $std_num $this_count\n";
						$ok = 0;
						last;
					} 
				}
			}
		}
		if($ok == 1){
			push @ok_words,$word;
		}
	}
	if(@ok_words){
		$print_line = join(" ",@ok_words);
		print "$print_line\n";
	}else{
		print "\n";
	}
}