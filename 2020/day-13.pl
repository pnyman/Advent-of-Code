use strict;
use warnings;
no warnings 'experimental';
use feature 'switch';
use Path::Tiny;
use List::Util 'min';
use DDP;

*STDIN = *DATA;
my @input = (<STDIN>);

# my @input = split /\n/, path('input/day-13-example.txt')->slurp;

sub part1 {
    my $timestamp = $input[0];
    my @ids       = grep length, split /[x,]/, $input[1];
    my @departures;
    for my $id (@ids) {
        my $time = 0;
        $time += $id while $time < $timestamp;
        push @departures, [ $time, $id ];
    }
    my $earliest = ( sort { $a->[0] <=> $b->[0] } @departures )[0];
    $earliest->[1] * ( $earliest->[0] - $timestamp );
}

sub part2 {
    my @ids = split /,/, $input[1];
    my @foo = map { [ $_, $ids[$_] ] } grep { $ids[$_] ne 'x' } 0 .. $#ids;
    my $x   = 1_068_773;

    # my $x = 100_000_000_000_000;
    # my $x = 1;
    LOOP: while (1) {
        ( $x + $_->[0] ) % $_->[1] and ++$x and next LOOP for @foo;
        return $x;
    }
}

sub part2x {
    my @ids = split /,/, $input[1];
    my @foo = map { [ $_, $ids[$_] ] } grep { $ids[$_] ne 'x' } 0 .. $#ids;

    my $step = $foo[0]->[1];
    my $x = 0;
    # my $x = 1_068_773;
    # my $x = 100_000_000_000_003;

    LOOP: while (1) {
        for (@foo) {
            if ( ( $x + @$_[0] ) % @$_[1] ) {
                $x += $step;
                next LOOP;
            }
        }
        return $x;
    }
}

# print part1, "\n";    # 3997
print part2x, "\n";

__DATA__
1111
1789,37,47,1889
67,7,x,59,61
67,x,7,59,61
67,7,59,61
17,x,13,19

__END__

    x % 7 =
    ( x + 1 ) % 13 =
    ( x + 4 ) % 59 =
    ( x + 6 ) % 31 =
    ( x + 7 ) % 19 = 0

    1068781

{x = 0 mod 7, (x+1) = 0 mod 13, (x+4) = 0 mod 59}
