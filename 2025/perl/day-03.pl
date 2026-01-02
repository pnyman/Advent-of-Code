use v5.38;
use Path::Tiny;
use List::Util qw(first max);
use Data::Dump;

my $input = '../input/day-03-input.txt';

sub get_input {
    map [ split // ], path($input)->lines( { chomp => 1 } );
}

sub part_1 {
    my $sum;

    for (get_input) {
        my @bank = @$_;
        my $max  = max @bank[ 0 .. $#bank - 1 ];
        my $idx  = first { $bank[$_] == $max } 0 .. $#bank;
        my $next = max @bank[ $idx + 1 .. $#bank ];
        $sum += 10 * $max + $next;
    }

    say $sum;
}

sub part_2 {
    my $sum;

    for (get_input) {
        my @bank  = @$_;
        my $count = @bank - 12;
        my @stack;
        for my $battery (@bank) {
            while ( @stack && $stack[-1] < $battery && $count ) {
                pop @stack;
                --$count;
            }
            push @stack, $battery;
        }
        $sum += join '', @stack[ 0 .. 11 ];
    }

    say $sum;
}

# dd get_input;

part_1;
part_2;
