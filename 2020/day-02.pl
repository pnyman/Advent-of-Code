use strict;
use warnings;
use v5.12;
use Path::Tiny;

my @input = split /\n/, path('input', 'day-02-input.txt')->slurp;

sub parse_line {
    /(\d+)-(\d+) ([a-z]): ([a-z]+)/;
    ( $1, $2, $3, $4 );
}

# part 1
my $ctr = 0;
for (@input) {
    my ( $min, $max, $letter, $pw ) = parse_line $_;
    my $count = ( $pw =~ s/$letter/$letter/g );
    $ctr++ if $min <= $count <= $max;
}
say $ctr;
# 474

# part 2
$ctr = 0;
for (@input) {
    my ( $min, $max, $letter, $pw ) = parse_line $_;
    my $count = 0;
    substr( $pw, --$_, 1 ) eq $letter and $count++ for $min, $max;
    $ctr++ if $count == 1;
}
say $ctr;
# 745
