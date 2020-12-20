#!/usr/bin/perl -w

$sig = 0;
$max = 0;
while($lines = <STDIN>){
	chomp $lines;
	#if($lines =~ /[0-9]*[\.]?[0-9]+/gi){
	@mat = $lines =~ /[-]?[0-9]*[\.]?[0-9]+/gi;
	
	@sort_mat = sort {$b <=> $a} @mat;

	if($#sort_mat > -1 && $sig == 0){
		$sig = 1;
		$max = $sort_mat[0];
		push @print_out,$lines;
	}elsif($#sort_mat > -1 && $sig == 1){
		if($max < $sort_mat[0]){
			shift @print_out;
			$max = $sort_mat[0];
			push @print_out,$lines;
		}
		elsif($max == $sort_mat[0]){
			push @print_out,$lines;
		}
	}
	
}

for $line (@print_out){
	print "$line\n";
}