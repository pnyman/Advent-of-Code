use strict;
use warnings;
use v5.12;
use Path::Tiny;
use DDP;

# 323 x 31

my @foo  = split /\n/, path('day-03-input.txt')->slurp;
my $cols = length $foo[0];
my %pos  = ( x => 0, y => 0 );

sub advance {
    my ( $dx, $dy ) = @_;
    $dx //= 3;
    $dy //= 1;
    $pos{x} = ( $pos{x} + $dx ) % $cols;
    $pos{y} += $dy;
}

my $count = 0;
while ( $pos{y} <= $#foo ) {
    $count++ if substr( $foo[ $pos{y} ], $pos{x}, 1 ) eq '#';
    advance;
}
say $count;

# 209

my $total = 1;
for ( [ 1, 1 ], [ 3, 1 ], [ 5, 1 ], [ 7, 1 ], [ 1, 2 ] ) {
    %pos   = ( x => 0, y => 0 );
    $count = 0;
    while ( $pos{y} <= $#foo ) {
        $count++ if substr( $foo[ $pos{y} ], $pos{x}, 1 ) eq '#';
        advance $_->[0], $_->[1];
    }
    $total *= $count;
}
say $total;

# 1574890240

# advance;
# p substr( $foo[ $pos{y} ], $pos{x}, 1 );
# advance;
# p substr( $foo[ $pos{y} ], $pos{x}, 1 );
