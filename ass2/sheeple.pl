#!/usr/bin/perl -w

open $in , '<',"$ARGV[0]" or die "$!";

$in_funtion = 0;
$is_read = 0;
print "#!/usr/bin/perl -w\n";

while ($line = <$in>){
	chomp $line;
	if($line =~ /#!\/bin\/.*/){
		next;
	}
	if($line eq ""){
		print "\n";
		next;
	}
	if($line =~ /^\s*(then|do) *$/){
		next;
	}

	#match for subset3 $[@*#]
	if($line =~ /[^\\]*\"? *\$([\@\*\#]) *\"?/){
		$para = $1;
		
		if($para eq "@" || $para eq "*"){
			$line =~ s/([^\\]*)\"? *\$([\@\*\#])( *)\"?/$1\@ARGV$3/g;
		}elsif($para eq "#"){
			$line =~ s/([^\\]*)\"? *\$([\@\*\#])( *)\"?/$1\$#ARGV+1$3/g;

		}
	}

	#for comment 
	if($line =~ /^ *#.*$/){
		print "$line\n";
		next;
	}
	#for post comment
	$comments = "";
	if($line =~ /^ *[^#]+[^ ]+( *#.*)$/ && $line !~ /\$\#ARGV/){
		$comments = $1;
		$line =~ s/(^ *[^#]+[^ ]+)( *#.*)$/$1/g;
	}

	#count for space at begining of line;
	$line =~ /^(\s*)/;
	$space = $1;
	$line =~ s/^(\s*)//;
	if($is_read == 1){
		$is_read = 0;
		print "${space}chomp \$$var;\n";
	}
	#match for args
	$line =~ /[^\\]\$([1-9][0-9]*)/;
	$arg_num = $1;
	$arg_num --;
	if($in_funtion == 0){
		$line =~ s/([^\\])\$([1-9][0-9]*)/$1\$ARGV[$arg_num]/g;
	}else{
		$line =~ s/([^\\])\$([1-9][0-9]*)/$1\$_[$arg_num]/g;
	}
	

	
	
	#subset 0 and double or single quote and subset3 arithmetic.
	if($line =~ /\s*echo (.*)$/){
        #erase ' of the echo sentence
        $line =~ s/(echo +)[\'\""]([^\']*)[\'\"]/$1$2/g;
        $line =~ s/\"/\\\"/g;
        #modify the file >>
        $line =~ s/echo +(.*) (>>?)([^ ]*) *$/open F, '$2', $3 or die;\n${space}print F \"$1\\n\";\n${space}close F/g;
        $line =~ s/echo +(.*) (>>?)([^ ]*) +(&&|\|\|) +(.*)$/open F, '$2', $3 or die;\nprint F \"$1\\n\";\nclose F;\n$5/g;

        #modify the echo -n
        if($line =~ /echo +\-n +(.*) +(&&|\|\|)(.*)$/){
        	$line =~ s/echo +\-n +(.*) +(&&|\|\|)(.*)$/print \"$1\" $2$3/g;
        }else{
        	$line =~ s/echo +\-n +(.*) *$/print \"$1\"/g;
        }
        #with && or  echo
        if($line =~ /echo +(.*) +(&&|\|\|)(.*)$/){
        	$line =~ s/echo +(.*) +(&&|\|\|)(.*)$/print \"$1\\n\" $2$3/g;
    	}else{
        	$line =~ s/echo +(.*) *$/print "$1\\n\"/g;
        }

	
	}
	if($line =~ /^(.*&&)? *(ls .*) */ || $line =~ /^(.*&&)? *(pwd) */ || $line =~/^(.*&&)? *(id) */ || $line =~ /^(.*&&)? *(date) */ || $line =~ /^(.*&&)? *(rm .*) */|| $line =~ /^(.*&&)? *(mv .*) */|| $line =~ /^(.*&&)? *(chmod .*) */){
		$line =~ s/(ls.*|rm.*|mv.*|chmod.*)/system \"$1\"/g;
		$line =~ s/(pwd|id|date)/system \"$1\"/g;
	}

	#match for arithmetic
	while($line =~ /([^=] *\$\(\() *([^\)&]+)(`|\)+) */){
		$value = $2;
		$value =~ s/\$//g;
		$value =~ s/([a-zA-Z]+)/\$$1/g;
		$value =~ s/\'|\"//g;
		$line =~ s/(\$\(\() *([^\)&]+)(`|\)+) */$value /;
	}

	while ($line =~ /([^=] \`expr *|\$\(expr *) *([^\)\`&]+)(\`|\)+) */) {
		$value = $2;
		$value =~ s/\'|\"//g;
		$line =~ s/(\`expr *|\$\(expr *) *([^\)\`&]+)(\`|\)+) */$value /;
	}
	
	#match for varible assignment
	while($line =~ /^(\s*|.*&&)(local)?([^ ]+)=([^=&]+)/){
		$var = $3;
		$right = $4;
		if($right =~ /^[0-9]*$|^ *[\$|\d][^\(]*$/){
			$value = $right;
		}
		elsif($right =~ /(\$\(\() *([^\)]+)(`|\)+) *$/){
			$value = $2;
			$value =~ s/\$//g;
			$value =~ s/([a-zA-Z]+)/\$$1/g;
			$value =~ s/\'|\"//g;
		}
		elsif($right =~ /(`expr *|\$\(expr *) *([^\)]+)(`|\)+) *$/){
			$value = $2;
			$value =~ s/\'|\"//g;
		}else{
			$value = "'$right'";
		}
		$line =~ s/([^ ]+)=([^=&]+)/\$$var = $value/g
		#print  "$space\$$var = $value;$comments\n";
	}

	#subset 1
	if($line =~ /\s*cd (.*)/){
		$dir = $1;
		$line =~ s/cd (.*)/chdir '$dir'/g;
		#print "${space}chdir '$dir';$comments\n";
	}
	if($line =~ /^\s*for (\S*) in (.*)$/){
		$var = $1;
		$value = $2;
		if($value =~ /[\*\?\[\]]/){
			$str = "glob(\"$value\")";
		}
		else{
			@range = split / /, $2;
			foreach $word (@range){
				if($word !~ /^[0-9]*$/ && $word !~ /^\@/){
					$word = "'$word'";
				}
			}
			$str = join(", ",@range);
		}
		#$line =~ s/for (\S*) in (.*)/ foreach \$$var ($str) {/g;
		print "${space}foreach \$$var ($str) {$comments\n";
		next;

	}

	if($line =~ /^\s*done\s*$/){
		print "${space}}$comments\n";
		next;
	}

	if($line =~ /^\s*read (.*)$/){
		$var = $1;
		print "${space}\$$var = <STDIN>;$comments\n";
		print "${space}chomp \$$var;\n";
		next;
	}

	if($line =~ /while +read (.*)$/){
		$var = $1;
		$is_read = 1;
		print "${space}while (\$$var = <STDIN>) {\n";
		next;
	}

	#subset 2 
	if($line =~ /^\s*(while|if|elif) +(test|\[).*/){

		$line =~ s/-o/\|\|/g;
		$line =~ s/-a/&&/g;

		$line =~ s/\"//g;

		#modify the left side varible
        $line =~ s/((test|\[|\|\||&&) +)([^\$\-\@ ][^ \d]+)/$1\'$3\'/g;


		#modify the right side value and -d/r 
		$line =~ s/(([=><]=?|-[^ ]+) +)([^\$\-\@ ][^ \d]+)/$1\'$3\'/g;

		#modify the symbol
		$line =~ s/ = / eq /g;
		$line =~ s/ != / ne /g;
		$line =~ s/ (\\)?< / lt /g;
		$line =~ s/ (\\)?> / gt /g;
		$line =~ s/ (\\)?<= / le /g;
		$line =~ s/ (\\)?>= / ge /g;
		$line =~ s/ -eq / == /g;
		$line =~ s/ -ne / != /g;
		$line =~ s/ -lt / < /g;
		$line =~ s/ -gt / > /g;
		$line =~ s/ -le / <= /g;
		$line =~ s/ -ge / >= /g;

		$line =~ s/test +//g;
		$line =~ s/^(\s*(while|if|elif) +)\[ +(.*) +\] *$/$1$3/g;
		#$line =~ s/ +\]//g;
		$line =~ s/^ *((while|if) +)(.*)$/$1\($3\) {/;
		$line =~ s/^ *(elif)( +)(.*)$/} elsif$2\($3\) {/;
		 
		print "${space}$line$comments\n";
		next;
	}
	if($line =~ /^ *else *$/){
		print "${space}} else {$comments\n";
		next;
	}
	if($line =~ /^ *fi *$/){
		print "${space}}$comments\n";
		next;
	}

	#subset4 for function
	if($line =~ /^([^ ]+)\( *\) +{ *$/){
		$fun_name = $1;
		push @funtions , $fun_name;
		$in_funtion = 1;

		$line =~ s/^([^ ]+)\( *\) +{/sub $1 {/;
		print "${space}$line$comments\n";
		next;
	}
	if($line =~ /^local .*$/){
		$line =~ s/ ([^ ]+)/ \$$1,/g;
		$line =~ s/local (.*)$/local \($1\)/;
		$line =~ s/,(\) *)$/$1/;
		$line =~ s/local/my/;
	}
	if($line =~ /^ *} *$/){
		$in_funtion = 0;
		print "${space}}\n";
		next;
	}

	#the test example shown tn example 4 primes.sh 
	if($line =~ /^( *|.*&& +)test/){

		$line =~ s/-o/\|\|/g;
		$line =~ s/-a/&&/g;

		$line =~ s/( *test +[^ ].* +)= /$1eq /g;
		$line =~ s/( *test +[^ ].* +)!= /$1ne /g;
		$line =~ s/( *test +[^ ].* +)(\\)?< /$1lt /g;
		$line =~ s/( *test +[^ ].* +)(\\)?> /$1gt /g;
		$line =~ s/( *test +[^ ].* +)(\\)?<= /$1le /g;
		$line =~ s/( *test +[^ ].* +)(\\)?>= /$1ge /g;
		$line =~ s/( *test +[^ ].* +)-eq /$1== /g;
		$line =~ s/( *test +[^ ].* +)-ne /$1!= /g;
		$line =~ s/( *test +[^ ].* +)-lt /$1< /g;
		$line =~ s/( *test +[^ ].* +)-gt /$1> /g;
		$line =~ s/( *test +[^ ].* +)-le /$1<= /g;
		$line =~ s/( *test +[^ ].* +)-ge /$1>= /g;

		$line =~ s/ *test +//g;
	}


    #match if some system call during if statement
	if($line =~ /^\s*(while|if|elif) +(true|false)/i){
		$line =~ s/(^\s*(while|if|elif) +)(true)/$1\(1) {/i;
		$line =~ s/(^\s*(while|if|elif) +)(false)/$1\(0) {/i;
		print "${space}$line$comments\n";
		next;
	}

	if($line =~ /^\s*(while|if|elif) +.*/){
		$line =~ s/(^\s*(while|if|elif) +)(.*)/$1\(! system \"$3\"\) {/;
		print "${space}$line$comments\n";
		next;
	}

	if(exists $funtions[0]){
		foreach $fun(@funtions){

			#add , between function parameters.
			if($line =~ /$fun +[^ ]+/){
				if($line =~ /($fun +)(([^ &\|]+ +)+)/){
					$add = $2;
					$add =~ s/([^ ]+)/$1,/g;
					$add =~ s/,( *)$/$1/g;
					$line =~ s/($fun +)(([^ &\|]+ +)+)/$1$add/g;
				}
			}
			#maybe some problem here when echo "fun_name 1 2" &&
			if($line =~ /$fun( +[^ ]+)+ +(&&|\|\|).*/){
				
				$line =~ s/($fun( +[^ ]+)+ +)&&/$1or/g;
				$line =~ s/($fun( +[^ ]+)+ +)\|\|/$1and/g;
			}
		}
	}
	$line =~ s/&&/and/g;
	$line =~ s/\|\|/or/g;
	print "${space}$line;$comments\n";
}

close($in);