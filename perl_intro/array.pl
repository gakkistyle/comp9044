#!/bin/perl -w

#@a = ("abc","x",123,44);

# print "the last is: $a[$#a]\n";

# print "the size is: $#a\n";


# while(1){
# 	print "Enter array index: ";
# 	$n = <STDIN>;
# 	if (!defined $n){
# 		last;
# 	}
# 	chomp $n;
# 	$a[$n] = 42;
# 	print "Array element $n now contains $a[$n]\n";
# 	printf "Array size is now %d\n",$#a+1;
# }

@list = (1,3,5,7,9);
$sum=0;

#sum of the list
$i=0;
for($i = 0;$i<$#list+1;$i++){
	$sum = $sum + $list[$i];
}
print "$sum\n";

#foreach
foreach $arg (@ARGV){
	print "$arg ";
}
print "\n";

for ($i = 0;$i <= $#ARGV;$i++)
{
	print "$ARGV[$i]$ARGV[$i]";
}

#join fountion
print "\n";
$string = join " ", @ARGV;
print "$string\n";
print "I was given ",scalar(@ARGV), " arguments\n";

#ways to read in and count lines
# while(1){
# 	$line = <STDIN>;
# 	if (!defined $line){
# 		last;
# 	}
# 	$count++;
# }
# print "$count lines\n";

# $count = 0;
# $count++ while defined <STDIN>;
# print "$count lines\n";


# @lines = <STDIN>;
# print $#lines +1," lines\n";


#defined use
# $a = <STDIN>;
# print "a=$a\n";

# if(defined $a){
# 	print "which is defined\n";
# }else{
# 	print "which is undefined\n";
# }

die "Usage: cp <source> <destination>\n" if @ARGV != 2;




