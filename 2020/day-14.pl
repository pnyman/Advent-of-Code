use strict;
use warnings;
use v5.12;
use Path::Tiny;
use List::Util 'sum';
use bigint;
use DDP;

# *STDIN = *DATA;
# undef $/;
# my @input = grep { $_ ne '' } split /mask\s*=\s*/, <STDIN>;

my @input = grep { $_ ne '' } split /mask\s*=\s*/,
  path('input/day-14-input.txt')->slurp;

sub part1 {
    my @memory = (0) x 100_000;

    for my $ip (@input) {
        my @record = split /\n/, $ip;
        my @mask   = split //,   shift @record;

        for (@record) {
            /^mem\[(\d+)\]\s*=\s*(\d+)/;
            my ( $pos, $val ) = ( $1, $2 );
            my @bin = split //, sprintf "%036b", $val;

            for my $i ( reverse 0 .. $#mask ) {
                next if $mask[$i] eq 'X';
                $bin[$i] = $mask[$i];
            }

            $memory[ -$pos ] = oct( "0b" . join( '', @bin ) );
        }
    }

    sum grep { $_ != 0 } @memory;
    # sum @memory;
}

say part1; # 10885823581193

__DATA__
mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
mem[8] = 11
mem[7] = 101
mem[8] = 0
mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
mem[8] = 11
mem[7] = 101
mem[8] = 0
