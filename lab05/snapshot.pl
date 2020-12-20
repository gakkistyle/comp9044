#!/usr/bin/perl -w

@files = glob( "*" );
if ( ($ARGV[0] eq "save") || ($ARGV[0] eq "load") ){
	$num = 0;
	$cp_dir = ".snapshot.$num";
	while(-e "$cp_dir"){
		$num++;
		$cp_dir = ".snapshot.$num";
	}
	mkdir( $cp_dir ) or die "$!";

	foreach $file(@files){
		if($file ne "snapshot.pl"){
			open my $in,'<',"$file" or die "$!";
			open my $out,'>',"$cp_dir/$file" or die "$!";
			while($line = <$in>){
				print $out "$line";
			}
			close $in;
			close $out;
		}
	}
	print "Creating snapshot $num\n";
}
if($ARGV[0] eq "load"){
	$back_num = $ARGV[1];
	$back_dir = ".snapshot.$back_num";
	foreach $file(@files){
		if($file ne "snapshot.pl"){
			unlink $file;
		}
	}
	my @newfiles = glob( "$back_dir/*" );
	foreach $newfile(@newfiles){
		open my $in,'<',"$newfile" or die "$!";
		$newfile =~  s/^.*\/(.*)$/$1/g;
		open my $out,'>',"$newfile" or die "$!";
		while($line = <$in>){
			print $out "$line";
		}
		close $in;
		close $out;
	}
	print "Restoring snapshot $back_num\n";
}