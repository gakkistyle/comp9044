
# while($line = <STDIN>){
# 	$line[$line_number++] = $line;
# }

# for ($line_number = $#line;$line_number >= 0;$line_number--){
# 	print $line[$line_number];
# }

# @lines = <STDIN>;
# print reverse @lines;

# print reverse <STDIN>;


# while($line = <STDIN>){
# 	push @lines,$line;
# }
# while(@lines){
# 	my $line = pop @lines;
# 	print $line;
# }

@lines = <STDIN>;
while(@lines){
	print pop @lines;
}

while ($line = <STDIN>){
	unshift @lines,$line;
}
print @lines;