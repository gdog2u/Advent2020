use warnings;
use strict;
use Data::Dumper;
use v5.10;
# require '../global.pl';

my @inputs = loadInput($ARGV[0]);

# The sum of all the things all of the groups have
#	Final answer we want
my $sumOfAllGroups = 0;

# Itterate through all groups' answers
foreach my $answers (@inputs)
{
	# Cast answer to array for ease-of-use
	my @answers = @{ $answers };
	# Initialize hash to store yes's in
	my %thingsGroupHas = ();
	my $peopleInGroup = 0;
	
	# Itterate through each person in the group
	foreach my $person (@answers)
	{
		my @thingsPersonHas = split(//, $person);
		$peopleInGroup++;
		
		foreach my $thing (@thingsPersonHas)
		{
			if(!defined $thingsGroupHas{$thing})
			{
				$thingsGroupHas{$thing} = 1;
			}
			else
			{
				$thingsGroupHas{$thing}++;
			}
		}
	}
	
	my $sumOfGroup = 0;
	
	foreach my $t (values %thingsGroupHas)
	{
		if($t == $peopleInGroup)
		{
			$sumOfGroup++;
		}
	}
	
	$sumOfAllGroups += $sumOfGroup;
}

debug("Sum of all of the groups: $sumOfAllGroups");

sub loadInput
{
	my $filename = $_[0];
		if(!defined $filename){ die "Please select a file for your inputs.\n\t"; }
	my @inputs = ();
	
	open(my $fh, '<', $filename);
	
	my $answers = [];
	while(my $line = <$fh>)
	{
		if($line =~ /^\s*$/)
		{
			push(@inputs, $answers);
			$answers = [];
			next;
		}
		
		chomp $line;
		
		push($answers, $line);
	}
	
	push(@inputs, $answers);
	
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