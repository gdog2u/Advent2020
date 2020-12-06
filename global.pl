use warnings;
use strict;
use Data::Dumper;
use v5.10;

sub loadInput
{
	my $filename = $_[0];
		if(!defined $filename){ die "Please select a file for your inputs.\n\t"; }
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
	my $debugMessage = $_[0];
	my $printLine = $_[1];
	
	say "DEBUG: $debugMessage";
	if($printLine)
	{
		my (undef, undef, $line) = caller;
		say "\tAt line: $line";
	}
}

1;