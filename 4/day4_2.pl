use warnings;
use strict;
use Data::Dumper;
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

	push(@return, $passport);

	return @return;
}

sub passportIsValid
{
	my @validKeys = (
		'byr',
		'iyr',
		'eyr',
		'hgt',
		'hcl',
		'ecl',
		'pid',
		'cid'
	);
	my %passport = %{ $_[0] };

	foreach my $key (@validKeys)
	{
		if(!defined($passport{$key}) && $key ne "cid")
		{
			# print "DEBUG: Couldn't find key: $key";
			return 0;
		 }
	}

	if($passport{'byr'} < 1920 || $passport{'byr'} > 2002)
	{ print "DEBUG: BYR: $passport{byr}\n"; return 0; }
	elsif($passport{'iyr'} < 2010 || $passport{'iyr'} > 2020)
	{ print "DEBUG: IYR: $passport{iyr}\n"; return 0; }
	elsif($passport{'eyr'} < 2020 || $passport{'eyr'} > 2030)
	{ print "DEBUG: EYR: $passport{eyr}\n"; return 0; }
	elsif($passport{'hgt'} !~ /^((59|6[0-9]|7[0-6])in)|((1([5678][0-9]|9[0-3]))cm)$/i)
	{ print "DEBUG: HGT $passport{hgt}\n"; return 0; }
	elsif($passport{'hcl'} !~ /^#[0-9a-f]{6}$/i)
	{ print "DEBUG: HCL $passport{hcl}\n"; return 0; }
	elsif($passport{'ecl'} !~ /(^amb|b(lu|rn)|gr(y|n)|hzl|oth$)/i)
	{ print "DEBUG: ECL $passport{ecl}\n"; return 0; }
	elsif($passport{'pid'} !~ /^[0-9]{9}$/)
	{ print "DEBUG: PID $passport{pid}\n"; return 0; }

	return 1;
}
