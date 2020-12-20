foreach $arg (@ARGV){
	print $arg, " ";
}

print "@ARGV\n";

print join(" ",@ARGV),"\n";

$sum = 0;
foreach $arg (@ARGV){
	$sum += $arg;
}

print "Sum pf the numbers is $sum\n";