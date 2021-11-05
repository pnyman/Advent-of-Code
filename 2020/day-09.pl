use strict;
use warnings;
no warnings 'recursion';
use Path::Tiny;
use List::Util qw|min max|;

my @input    = split /\n/, path('input/day-09-input.txt')->slurp;
my $preamble = 25;

sub part1 {
    my @data    = shift->@*;
    my $goal    = $data[$preamble];
    my $foundit = 0;

    LOOP: for my $i ( 0 .. $preamble - 2 ) {
        for my $j ( $i + 1 .. $preamble - 1 ) {
            ++$foundit and last LOOP if $data[$i] + $data[$j] == $goal;
        }
    }

    return $goal if !$foundit;
    part1( [ @data[ 1 .. $#data ] ] );
}

sub part2 {
    my $goal  = shift;
    my $start = 0;

    while (1) {
        my @set = ();
        my $sum = 0;
        for ( $start .. $#input ) {
            $sum += $input[$_];
            ++$start and last if $sum > $goal;
            push @set, $input[$_];
            return min(@set) + max(@set) if $sum == $goal;
        }
    }
}

my $answer1 = part1( \@input );
my $answer2 = part2($answer1);

print $answer1, "\n";    # 400480901
print $answer2, "\n";    # 67587168
