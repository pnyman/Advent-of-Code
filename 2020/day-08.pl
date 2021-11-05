use strict;
use warnings;
no warnings 'experimental';
no warnings 'recursion';
use feature 'switch';
use Path::Tiny;

my @data = split /\n/, path('input/day-08-input.txt')->slurp;

sub part1 {
    my @input       = shift->@*;
    my $index       = shift // 0;
    my $accumulator = shift // 0;
    my $visited     = shift // {};

    return [ 1, $accumulator ] if $index > $#input;
    return [ 0, $accumulator ] if $visited->{$index};

    $visited->{$index}++;

    my ( $operation, $argument ) = split /\s+/, $input[$index];
    given ($operation) {
        when ('acc') {
            $accumulator += $argument;
            $index++;
        }
        when ('jmp') {
            $index += $argument;
        }
        when ('nop') {
            $index++;
        }
    }

    part1( \@input, $index, $accumulator, $visited );
}

sub part2 {
    my @input = shift->@*;
    my $start = shift // 0;

    my @clone = @input;

    ## Start from where we left off, and make one change to @clone.
    for my $index ( $start .. $#clone ) {
        my ( $operation, $argument ) = split /\s+/, $clone[$index];

        given ($operation) {
            when ('jmp') {
                $clone[$index] = join ' ', 'nop', $argument;
                $start = $index + 1;
                last;
            }
            when ('nop') {
                $clone[$index] = join ' ', 'jmp', $argument;
                $start = $index + 1;
                last;
            }
        }
    }

    ## If the first returned value of part1() is true, we have found our answer.
    my $result = part1( \@clone );
    return $result->[1] if $result->[0];
    part2( \@input, $start );
}

print part1( \@data )->[1], "\n";    # 1797
print part2( \@data ), "\n";         # 1036
