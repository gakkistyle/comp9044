#!/usr/bin/perl -w

@time_slot = (9,10,11,12,13,14,15,16,17,18,19,20);
@day_slot = ("Mon","Tue","Wed","Thu","Fri");

use LWP::Simple;
for $cor(@ARGV){
	#http://timetable.unsw.edu.au/2020/COMP2041.html
	$url = "http://www.timetable.unsw.edu.au/2020/${cor}.html";
	$web_page = get($url) or die "Unable to get $url";
	print "$web_page" ;
}
