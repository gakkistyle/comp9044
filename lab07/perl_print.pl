#!/usr/bin/perl -w

print "#!/usr/bin/perl -w\n";
if($ARGV[0] =~ /\\/){
    $a = $ARGV[0];
    $a =~ s/\\/\\\\/g;
    print "print \"$a\\n\";";
}elsif($ARGV[0] =~ /"/){
    $a = $ARGV[0];
    $a =~ s/"/\\"/g;
    print "print \"$a\\n\";";
}else{
    print "print \"$ARGV[0]\\n\";";
}