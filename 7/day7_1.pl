use warnings;
use strict;
use JSON;
require '../global.pl';

our %bagRules = ();
my @inputs = loadInput($ARGV[0]);
# debug("# of rules: ".(scalar @inputs));
my $searchingFor = $ARGV[1];

parseBags(\@inputs);

# print encode_json(\%bagRules);
# exit;
# Number of bags I can find $searchingFor in, and final return
my $count = 0;
foreach my $searchSpace (keys %::bagRules)
{
	# debug("Searching in: $searchSpace");
	if(searchForBag($searchingFor, $searchSpace))
	{ $count++; }
}

debug("I can find $searchingFor in $count bags");

sub searchForBag
{
	my $bag = $_[0]; #shiny gold, in our case
	my $searchSpaceKey = $_[1]; # Key in the %bagRules hash
	
	my @searchSpace = @{ $::bagRules{$searchSpaceKey} };
	
	# Search space is empty
	if(scalar @searchSpace == 0)
	{ return 0; }
	# Found the bag
	elsif(grep(/^$bag$/, @searchSpace))
	{ return 1; }
	# Search all of this bag's children
	else
	{
		foreach my $newKey (@searchSpace)
		{
			return searchForBag($bag, $newKey);
		}
	}
}

sub parseBags 
{
	my @rules = @{ $_[0] };
	
	foreach my $rule (@rules)
	{
		$rule =~ /(.+?) bags contain (.+?)\./;
		my $bag = $1;
		$::bagRules{$bag} = [];
		
		if($2 eq "no other bags")
		{
			next;
		}
		
		
		my @subBags = split(/, /, $2);
		
		foreach my $subBag (@subBags)
		{
			$subBag =~ /\d+ (.+?) bag[s]?/;
			push($::bagRules{$bag}, $1);
		}
	}
}