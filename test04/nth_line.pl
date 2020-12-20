#!/usr/bin/perl -w

$filename = $ARGV[1];
$nth = $ARGV[0];
open $file , '<', $filename or die $!;

@content = <$file>;
if($nth > $#content+1){
	exit 0;
}

print $content[$nth-1];

close($file);