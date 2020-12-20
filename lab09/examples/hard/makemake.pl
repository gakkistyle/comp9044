#!/usr/bin/perl -w

$da = `date`;
print "# Makefile generated at $da\n";
print "CC = gcc\nCFLAGS = -Wall -g\n\n";

foreach $file(glob "*.c"){
    open $in,"<","$file" or die "$!";
    $file =~ /(.*)\.c/;
    $ob = "$1.o";
    while($line = <$in>){

        if($line =~ /^\s*#include *"(.*.h)"/){
            build($ob,$1,\%depen);
            #$depen{$ob} .= " $1";
        }
        if($line =~ /^\s*(int|void)\s*main\s*\(/){
            #print "shiiiiit";
            $main = $ob;
        }

    }
    if(exists $depen{$ob}){
        $depen{$ob} .= " $file";
    }
    #print "$depen{$ob}\n";
    close($in);
}

#determine the format of printing
$max_len = 0;
foreach $k(keys %depen){
    if(length($k) > $max_len){
        $max_len = length($k);
    }
}
$max_len ++;

#main build
$main_o = $depen{$main};
$main_o =~ s/\.[ch]/\.o/g;
$main =~ /(.*)\.o/;
printf "%-${max_len}s$main_o\n","$1:";
print "\t\$(CC) \$(CFLAGS) -o \$\@$main_o\n\n";


foreach $k(keys %depen){
    printf "%-${max_len}s$depen{$k}\n","$k:";
}

sub build{
    my ($k,$target,$ref_depen) = @_;
    if(exists $$ref_depen{$k} && $$ref_depen{$k} =~ /$target/){
        return;
    }
    $$ref_depen{$k} .= " $target";
    open my $in1,"<","$target" or die "can not open $target $!";
    while(my $line2 = <$in1>){
        if($line2 =~ /^\s*#include *"(.*.h)"/){
            
            build($k,$1,\%$ref_depen);
        }
    }
    close($in1);
}

