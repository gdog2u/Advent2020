use warnings;
use strict;
use v5.10;

sub loadInput
{
	my $filename = $_[0];
	my @inputs = ();
	
	open(my $fh, '<', $filename);
	
	while(my $line = <$fh>)
	{
		chomp $line;
		push(@inputs, $line);
	}
	
	return @inputs;
}

sub debug
{
	say "DEBUG: $_[0]";
}

1;