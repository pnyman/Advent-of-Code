use strict;
use warnings;
use v5.12;

sub solve {
    my $limit = shift;
    my @input = ( 13, 0, 10, 12, 1, 5, 8 );
    my $turn  = 0;
    my %spoken;
    $spoken{$_} = [ ++$turn ] for @input;
    my $this = $input[-1];

    for ( 1 + @input .. $limit ) {
        ++$turn;

        if ( !$spoken{$this} || $spoken{$this}->@* == 1 ) {
            $this = 0;
        }

        else {
            $this = $spoken{$this}->[-1] - $spoken{$this}->[-2];
        }

        push $spoken{$this}->@*, $turn;
    }

    $this;
}

say solve(2020);        # 260
say solve(30000000);    # 950
