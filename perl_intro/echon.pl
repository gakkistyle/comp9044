#!/user/bin/perl

if($#ARGV != 1){
	die "Usage: $0 <number of lines> <string>\n";
}
if($ARGV[0] < 0){
	die "$0:argument 1 must be a non-negative integer\n";
} 

$i  = 0;
while($i < $ARGV[0]){
	print "$ARGV[1]\n";
	$i++;
}