use strict;
use warnings;
use v5.12;
use Path::Tiny;
use DDP;

my @foo = split /\n/, path('input', 'day-05-input.txt')->slurp;
my @ids;

for my $f (@foo) {
    my @rows = 0 .. 127;
    for ( 0 .. 6 ) {
        my $half = int( @rows / 2 );
        @rows
          = substr( $f, $_, 1 ) eq 'F'
          ? @rows[ 0 .. $half - 1 ]
          : @rows[ $half .. $#rows ];
    }

    my @seats = 0 .. 7;
    for ( 7 .. 9 ) {
        my $half = int( @seats / 2 );
        @seats
          = substr( $f, $_, 1 ) eq 'L'
          ? @seats[ 0 .. $half - 1 ]
          : @seats[ $half .. $#seats ];
    }

    push @ids, $rows[0] * 8 + $seats[0];
}

@ids = sort { $a <=> $b } @ids;
say $ids[-1];
$ids[ $_ + 1 ] - $ids[$_] == 2 and say $ids[$_] + 1 for 0 .. $#ids - 1;
