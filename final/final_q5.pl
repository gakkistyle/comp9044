#!/usr/bin/perl -w

while($line = <STDIN>){
	chomp $line;
	if($line =~ /^[^\d]*(\d+).*?(\d+)[^\d]*$/){
		$num1 = $1;
		$num2 = $2;
		$line =~ s/^([^\d]*)(\d+)(.*?)(\d+)([^\d]*)$/$1$num2$3$num1$5/;
	}
	print "$line\n"
}