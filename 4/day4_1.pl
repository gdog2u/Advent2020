use warnings;
use strict;
use Data::Dumper;
use Array::Utils qw(array_diff);
# require '../global.pl';

my @passports = loadInput($ARGV[0]);

my $validPassports = 0;
foreach my $passport (@passports)
{
	if(passportIsValid($passport))
	{
		$validPassports++;
	}
}

print "Valid passports: $validPassports\n";

sub loadInput
{
	my $filename = $_[0];
	my @return = ();

	open(my $fh, '<', $filename);
	my $passport = {};
	while(my $line = <$fh>)
	{
		if($line =~ /^\s*$/)
		{
			push(@return, $passport);
			$passport = {};
			next;
		}

		chomp $line;

		my @pairs = split(/ /, $line);
		foreach my $keyValue (@pairs)
		{
			my ($key, $value) = split(/:/, $keyValue);

			$passport->{$key} = $value;
		}
	}

	return @return;
}

sub passportIsValid
{
	state @validKeys = (
		'byr',
		'iyr',
		'eyr',
		'hgt',
		'hcl',
		'ecl',
		'pid',
		'cid'
	);
	my @keys = keys %{ $_[0] };

	if(!array_diff(\@validKeys, \@keys))
	{
		return 1;
	}
	elsif((scalar array_diff(\@validKeys, \@keys)) == 1 && !grep(/^cid$/, @keys))
	{
		return 1;
	}

	return 0;
}