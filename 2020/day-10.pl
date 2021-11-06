use strict;
use warnings;
use Path::Tiny;
use List::Util qw|max|;
use DDP;

# my @input = split /\n/, path('input/day-10-example-2.txt')->slurp;
my @input = split /\n/, path('input/day-10-input.txt')->slurp;

print "@input", "\n";

sub part1 {
    my %adapters;
    $adapters{$_}++ for @input;
    my $jolt            = 0;
    my $difference_of_1 = 0;
    my $difference_of_3 = 1;
    LOOP: while ( $jolt < max( keys %adapters ) ) {
        for ( $jolt + 1 .. $jolt + 3 ) {
            next unless exists $adapters{$_};
            $difference_of_1++ if $_ - $jolt == 1;
            $difference_of_3++ if $_ - $jolt == 3;
            $jolt = $_;
            next LOOP;
        }
    }
    $difference_of_1 * $difference_of_3;
}

sub part2 {
    ## We add the outlet and the device to @sorted.
    my @sorted = ( 0, sort { $a <=> $b } @input, max(@input) + 3 );

    ## The size of the runs of consecutive values
    ## determines the combinatoric possibilities.
    ## The first and last value in a run must always be present.
    ## Hence, if a group has size 4 we can select between 2, etc.
    ## For group size 5, we must select at least one of the 3,
    ## so we don't get a gap > 3.
    my ( $arrangements, $run ) = ( 1, 1 );
    for ( 1 .. $#sorted ) {
        ++$run and next if $sorted[$_] - $sorted[ $_ - 1 ] == 1;
        $arrangements *= { 5 => 7, 4 => 4, 3 => 2 }->{$run} || 1;
        $run = 1;
    }

    $arrangements;
}

print part1, "\n";    # 2475
print part2, "\n";    # 442136281481216

__END__
1 2 3 4 7 8 9 10 11 14 17 18 19 20 23 24 25 28 31 32 33 34 35 38 39 42 45 46 47 48 49

0 1 2 3 4       -> 7
7 8 9 10 11     -> 7
14
17 18 19 20     -> 4
23 24 25        -> 2
28
31 32 33 34 35  -> 7
38 39           -> 1
42
45 46 47 48 49  -> 7

runs: 5 5 4 3 5 2 5


no warnings 'experimental';
use feature 'switch';

sub part2x {
    ## We add the outlet (0) and the device to @sorted.
    my @sorted = ( 0, sort { $a <=> $b } @input, max(@input) + 3 );

    ## The size of the runs of consecutive values
    ## determines the combinatoric possibilities.
    my ( @runs, $r ) = ( (), 0 );
    for my $i ( 1 .. $#sorted ) {
        if ( $sorted[$i] - $sorted[ $i - 1 ] == 1 ) {
            ++$r;
        }
        elsif ($r) {
            push @runs, ++$r;
            $r = 0;
        }
    }

    ## The first and last value in a run must always be present.
    ## Hence, if a group has size 5 we can select between 3, etc.
    ## For group size 5, we must select at least one of the 3,
    ## so we don't get a gap > 3.
    my $arrangements = 1;
    for (@runs) {
        given ($_) {
            $arrangements *= 7 when 5;
            $arrangements *= 4 when 4;
            $arrangements *= 2 when 3;
            $arrangements *= 1 when 2;
        }
    }

    $arrangements;
}
