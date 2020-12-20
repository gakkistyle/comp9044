#!/bin/perl

$line_count = 0;
# while(1){
# 	$line = <STDIN>;
# 	last if !$line;
# 	$line_count++;
# }

# print "$line_count lines\n";

# while(<STDIN>){
# 	$line_count++;
# }
# print "$line_count lines\n";

# $line_count++ while <STDIN>;
# print "$line_count lines\n";

# () = <STDIN>;
# print "$. lines\n";

@lines = <STDIN>;
print $#lines+1," lines\n";