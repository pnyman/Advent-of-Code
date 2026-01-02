use v5.38;
use Path::Tiny;
use POSIX qw(floor);

my $input = '../input/day-01-input.txt';

sub get_input {
    map { chomp; tr/LR/-/rd } path($input)->lines;
}

sub passes ( $start, $step ) {
    return 0 if $step == 0;
    my $ending = $start + $step;
    return floor( $ending / 100 ) if $step > 0;
    floor( --$start / 100 ) - floor( --$ending / 100 );
}

my $arrow = 50;
my ( $zeroes, $clicks );

for (get_input) {
    $clicks += passes $arrow, $_;
    $arrow = ( $arrow + $_ ) % 100;
    $zeroes++ if $arrow == 0;
}

# 1135, 6558
say $zeroes, ', ', $clicks;
