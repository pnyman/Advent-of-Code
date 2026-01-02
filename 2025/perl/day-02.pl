use v5.38;
use Path::Tiny;

my $input = '../input/day-02-input.txt';

sub get_input {
    map { [ split /-/ ] } map { chomp; split /,/ } path($input)->slurp;
}

my ( $part_1, $part_2 );

for my $range (get_input) {
    for my $num ( $range->[0] .. $range->[1] ) {
        next unless $num =~ /^(.+)\1+$/;
        $part_2 += $num;
        next unless $num =~ /^(.+)\1$/;
        $part_1 += $num;
    }
}

# 28846518423, 31578210022
say $part_1, ', ', $part_2;
