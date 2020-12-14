use warnings;
use strict;
require '../global.pl';

my @inputs = loadInput($ARGV[0]);
my @seatIDs = ();
my $highestID = -1;

foreach my $pass (@inputs)
{
	my (undef, $row, $column) = split(/(.{7})(.{3})/, $pass);
	
	# Convert row string to binary
	$row =~ s/F/0/g;
	$row =~ s/B/1/g;
	my $rowID = oct('0b'.$row);
	
	# Convert column string to binary
	$column =~ s/L/0/g;
	$column =~ s/R/1/g;
	my $columnID = oct('0b'.$column);
	
	my $seatID = $rowID * 8 + $columnID;
	push(@seatIDs, $seatID);
	
	$highestID = $seatID > $highestID ? $seatID : $highestID;
}

debug("Highest seat ID: $highestID");