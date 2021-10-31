use strict;
use warnings;
use v5.12;
use Path::Tiny;
use List::Util 'max';

my %seats;
$seats{ find_seat($_) }++
  for split /\n/, path('input/day-05-input.txt')->slurp;
my $max_id = max keys %seats;

say $max_id;
!exists $seats{$_} and say and last for reverse 0 .. $max_id;

sub find_seat {
    oct '0b' . join '', map { to_bit($_) } split //;
}

sub to_bit {
    { F => 0, B => 1, L => 0, R => 1 }->{ $_[0] };
}
