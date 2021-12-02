use strict;
use warnings;
use Path::Tiny;
use v5.30;

my @input = split /\n/, path('input/day-01-input.txt')->slurp;
say scalar grep { $input[$_] < $input[ $_ + 1 ] } 0 .. @input - 2;
say scalar grep { $input[$_] < $input[ $_ + 3 ] } 0 .. @input - 4;
