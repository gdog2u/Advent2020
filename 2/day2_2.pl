use warnings;
use strict "refs";
use Data::Dumper;
require '../global.pl';

my @inputs = loadInput($ARGV[0]);

$correctPasswords = 0;

foreach my $password (@inputs)
{
	$password =~ /(\d+)\-(\d+) (.): (.+)/;
	
	my $position_a = $1;
	my $position_b = $2;
	my $char = $3;
	$password = $4;
	
	my @passwordChars = split(//, $password);
	
	if(($passwordChars[$position_a-1] eq $char || $passwordChars[$position_b-1] eq $char)
		&& ($passwordChars[$position_a-1] ne $passwordChars[$position_b-1]))
	{
		$correctPasswords++;
	}
}

debug("Correct passwords: $correctPasswords");

