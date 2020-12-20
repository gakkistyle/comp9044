#!/usr/bin/perl -w
sub uniq {
    my %seen;
    grep !$seen{$_}++, @_;
}

$tar = $ARGV[0];

use LWP::Simple;
$url = "http://www.timetable.unsw.edu.au/current/$ARGV[0]KENS.html";
$web_page = get($url) or die "Unable to get $url";

@lines = split(/\n/,$web_page);
#print $lines[$#lines-1];
foreach $line (@lines){
	#print $line;
	if($line =~ /^ *<td class="data">.*"$tar[0-9]*.*">.*<\/a><\/td>/){
		if($line =~ /.*$tar[0-9]*.*$tar[0-9]*/){
			#print "$line";
			next;
		}
		$line =~ /^ *<td class="data">.*"($tar[0-9]*)\.html.*">(.*)<\/a><\/td>/;
		$good = "$1 $2";
		push @match,$good;
	}
}
@match = sort @match;
@match = uniq(@match);
foreach $line (@match){
	print "$line\n";
}