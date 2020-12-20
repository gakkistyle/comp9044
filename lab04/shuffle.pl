#!/bin/perl -w

chomp(@contents = <STDIN>);

$num = $#contents+0.9;

while($#record != $#contents){
	$seed = rand($num);
	$seed =~ s/.[0-9]+//g;
	$flag=0;
	for $i(@record){
		if ($i == $seed){
			$flag = 1;
			last;
		}
	}
	if($flag != 1){
		push @record,$seed;
	    print "$contents[$seed]\n";
    }
	
}
