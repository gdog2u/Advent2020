use warnings;
use strict;
require '../global.pl';

my @inputs = loadInput($ARGV[0]);
my @seatIDs = ();
my $mySeat = undef;

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
}
# Sort IDs in ASC order
@seatIDs = sort {$a <=> $b} @seatIDs;
# Get min and max IDs
my $min = $seatIDs[0];
my $max = $seatIDs[$#seatIDs];
# Really not sure why this didn't catch.
# Loop through all possible IDs between min/max
# for(63..935)
# {
	# # if($mySeat){ next; }
	# if(!grep(/^$_$/, @seatIDs))
	# {
		# debug("Found $_ is missing");
		# my $above = $_ + 1;
		# my $below = $_ - 1;
		
		# if(grep(/^$above$/, @seatIDs) && grep(/^$below$/, @seatIDs))
		# {
			# $mySeat = $_;
		# }
		# else
		# {
			# debug("But $above and $below aren't there, so it must not be mine...");
			# <STDIN>;
		# }
	# }
# }
for(my $i = 0; $i < $#seatIDs; $i++)
{
	if($seatIDs[$i] != ($seatIDs[$i+1] -1))
	{
		$mySeat = $seatIDs[$i] + 1;
	}
}

if($mySeat)
{
	debug("My Seat is: $mySeat");
}
else
{
	debug("Couldn't find my seat :(");
}