use v5.38;
use Path::Tiny;
use List::Util qw(max);
use Data::Dump;

my $input = '../input/day-09-input.txt';

sub get_input {
    map [ split /,/ ], path($input)->lines( { chomp => 1 } );
}

sub area ( $p1, $p2 ) {
    abs( $p1->[0] - $p2->[0] + 1 ) * abs( $p1->[1] - $p2->[1] + 1 );

}

sub part_1 {
    my @areas;
    my @points = get_input;
    for my $i ( 0 .. $#points - 1 ) {
        for my $j ( $i + 1 .. $#points ) {
            push @areas, area $points[$i], $points[$j];
        }
    }
    say max @areas;
}

# sub part_2 {
#     my @areas;
#     my @points = get_input;
#     for my $i ( 0 .. $#points - 1 ) {
#         for my $j ( $i + 1 .. $#points ) {
#             if ($i + $j)
#             push @areas, area $points[$i], $points[$j];
#         }
#     }
#     say max @areas;
# }

part_1;
