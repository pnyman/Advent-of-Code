use strict;
use warnings;
use v5.12;

$/ = '';
open my $fh, '<', 'input/day-06-input.txt';
my ( $answer1, $answer2 ) = ( 0, 0 );

for (<$fh>) {
    my %questions;
    my $persons = split /\n/;
    $questions{$_}++ for split /\n|/;
    $answer1 += %questions;
    $answer2 += grep $_ == $persons, values %questions;
}

say $answer1;
say $answer2;

# 6351
# 3143
