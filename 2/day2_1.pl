use warnings;
use strict "refs";
use Data::Dumper;
require '../global.pl';

my @inputs = loadInput($ARGV[0]);

$correctPasswords = 0;

foreach my $password (@inputs)
{
	$password =~ /(\d+)\-(\d+) (.): (.+)/;
	
	my $min = $1;
	my $max = $2;
	my $char = $3;
	$password = $4;
	
	my @passwordChars = split(//, $password);
	
	$occurs = countOccurances(\@passwordChars, $char);
	
	if($occurs >= $min && $occurs <= $max){ $correctPasswords++; }
}

debug("Correct passwords: $correctPasswords");

sub countOccurances
{
	my @chars = @{ $_[0] };
	my $toCount = $_[1];
	my $occurances = 0;
	
	for(my $i = 0; $i < scalar @chars; $i++)
	{
		if($chars[$i] eq $toCount){ $occurances++; }
	}
	
	return $occurances;
}