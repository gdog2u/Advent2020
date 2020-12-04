use warnings;
use strict;
use Data::Dumper;
require '../global.pl';

my @inputs = loadInput($ARGV[0]);

my $index_a = -1;
my $index_b = -1;

for(my $i = 0; $i < ((scalar @inputs) / 2); $i++)
{
	if($index_a != -1){ next; }
	
	for(my $j = $i+1; $j < scalar @inputs; $j++)
	{
		if($inputs[$i] + $inputs[$j] == 2020)
		{
			$index_a = $i;
			$index_b = $j;
		}
	}
}

debug("index_a: $index_a");
debug("index_b: $index_b");
debug("Product: ".($inputs[$index_a] * $inputs[$index_b]));