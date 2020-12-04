use warnings;
use strict;
use Data::Dumper;
require '../global.pl';

my @inputs = loadInput($ARGV[0]);

my $index_a = -1;
my $index_b = -1;
my $index_c = -1;

my $inputsLength = scalar @inputs;

for(my $i = 0; $i < ($inputsLength / 3); $i++)
{
	if($index_a != -1){ next; }
	
	for(my $j = $i+1; $j < (($inputsLength / 3)+($inputsLength / 3)); $j++)
	{		
		for(my $k = $j+1; $k < scalar @inputs; $k++)
		{
			if($inputs[$i] + $inputs[$j] + $inputs[$k] == 2020)
			{
				$index_a = $i;
				$index_b = $j;
				$index_c = $k;
			}
		}
	}
}

debug("index_a: $index_a");
debug("index_b: $index_b");
debug("index_c: $index_c");
debug("Product: ".($inputs[$index_a] * $inputs[$index_b] * $inputs[$index_c]));