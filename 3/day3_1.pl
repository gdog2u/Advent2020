use warnings;
use strict;
require '../global.pl';

my @inputs = loadInput($ARGV[0]);
# Validate input
my $rise = $ARGV[1];
	if(!defined $rise || $rise !~ /^[0-9]+$/)
	{
		die "Please enter a rise integer";
	}
my $run = $ARGV[2];
	if(!defined $run || $run !~ /^[0-9]+$/)
	{
		die "Please enter a run integer";
	}

# Parse the map
my @map = ();
my $MAX_X = 0; # The max index of the x-axis of the map
foreach my $rowText (@inputs)
{
	my @row = split(//, $rowText);
	if(!$MAX_X){ $MAX_X = scalar @row; }
	push(@map, \@row);
}
# Step through map
my %position = ( # Create a faux vector to keep track of current position
	'x' => 0,
	'y' => 0
);
my $treesEncountered = 0;
while($position{'y'} < scalar @map)
{
	if($map[$position{'y'}][$position{'x'} % $MAX_X] eq '#')
	{
		$treesEncountered++;
	}
	
	$position{'y'} += $rise;
	$position{'x'} += $run;
}

debug("Trees encountered: $treesEncountered");