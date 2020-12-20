#!/usr/bin/perl -w

while ($line = <STDIN>) {
	chomp $line;
	if ($line le 'zibra') {
		print "this is a word smaller than zibra\n";
	} else {
		print "a really big word, then let us end\n";
		exit 0;
	}
}
