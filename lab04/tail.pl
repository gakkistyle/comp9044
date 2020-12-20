#!/bin/perl -w

$num_lines = 10;
if($#ARGV > -1 && $ARGV[0] =~ '^-[0-9]*$'){
	$num_lines = shift @ARGV;
	$num_lines =~ s/^-//;
}

if($#ARGV > -1){
	foreach $file(@ARGV){
		if($#ARGV>0){
			print "==> $file <==\n";
		}
		open $in,'<',$file or die "$0: Can't open $file: $!\n";
        chomp(@content = <$in>);
        @content = reverse @content;
        
        $i = $num_lines;
        if($num_lines>$#content+1){
        	$i = $#content+1;
        }
        while($i>0){
        	print "$content[$i-1]\n";
        	$i--;
        }
		close $in;
	}
}else{
	chomp(@content = <STDIN>);
    @content = reverse @content;
    $i = $num_lines;
    if($num_lines>$#content+1){
        	$i = $#content+1;
     }
    while($i>0){
        print "$content[$i-1]\n";
        $i--;
    }
}
