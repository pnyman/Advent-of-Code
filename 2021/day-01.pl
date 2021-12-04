use strict;
use warnings;
use v5.30;
use Path::Tiny;

my @input = split /\n/, path('input/day-01-input.txt')->slurp;

sub solve {
    my ( $input, $window ) = @_;
    scalar grep { @$input[$_] < @$input[ $_ + $window ] } 0 .. $#$input - $window;
}

say solve \@input, 1;
say solve \@input, 3;
