use warnings;
use strict;
use Data::Dumper;
require '../global.pl';

my @inputs = loadInput($ARGV[0]);
my @slopes = loadInput($ARGV[1]);

# Parse the map
our @map = ();
our $MAX_X = 0; # The max index of the x-axis of the map
foreach my $rowText (@inputs)
{
	my @row = split(//, $rowText);
	if(!$MAX_X){ $MAX_X = scalar @row; }
	push(@map, \@row);
}

for(my $i = 0; $i < scalar @slopes; $i++)
{
	$slopes[$i] =~ /(\d+),(\d+)/;
	$slopes[$i] = [$1, $2];
}

my $productOfTreesEncountered = 1;
foreach my $slope (@slopes)
{
	# debug("Rise: $slope->[0]");
	# debug("Run:  $slope->[1]");

	my $treesEncountered = getTreesEncountered($slope->[0], $slope->[1]);
	# debug("Trees encountered: $treesEncountered");
	$productOfTreesEncountered *= $treesEncountered;
}

debug("Product: $productOfTreesEncountered");

# Step through map
sub getTreesEncountered
{
	my $rise = $_[0];
	my $run = $_[1];

	my %position = ( # Create a faux vector to keep track of current position
		'x' => 0,
		'y' => 0
	);
	my $treesEncountered = 0;

	while($position{'y'} < scalar @::map)
	{
		if($map[$position{'y'}][$position{'x'} % $::MAX_X] eq '#')
		{
			$treesEncountered++;
		}

		$position{'y'} += $rise;
		$position{'x'} += $run;
	}

	return $treesEncountered;
}
