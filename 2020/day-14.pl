use strict;
use warnings;
use v5.12;
use bigint;
use Path::Tiny;
use List::Util 'sum';
use Algorithm::Combinatorics 'variations_with_repetition';
use DDP;

# *STDIN = *DATA;
# undef $/;
# my @input = grep { $_ ne '' } split /mask\s*=\s*/, <STDIN>;

my @input = grep { $_ ne '' } split /mask\s*=\s*/,
  path('input/day-14-input.txt')->slurp;

sub part1 {
    my %memory;

    for my $ip (@input) {
        my @record = split /\n/, $ip;
        my @mask   = split //,   shift @record;

        for (@record) {
            my ( $pos, $val ) = /^mem\[(\d+)\]\s*=\s*(\d+)/;
            my @bin = split //, sprintf "%036b", $val;

            for my $i ( reverse 0 .. $#mask ) {
                next if $mask[$i] eq 'X';
                $bin[$i] = $mask[$i];
            }

            $memory{$pos} = oct( "0b" . join( '', @bin ) );
        }
    }

    sum values %memory;
}

sub part2 {
    my %memory;

    for my $ip (@input) {
        my @record = split /\n/, $ip;
        my @mask   = split //,   shift @record;

        for (@record) {
            my ( $pos, $val ) = /^mem\[(\d+)\]\s*=\s*(\d+)/;
            my @bin = split //, sprintf "%036b", $pos;
            my @xs  = ();

            for my $i ( reverse 0 .. $#mask ) {
                next         if $mask[$i] eq '0';
                $bin[$i] = 1 if $mask[$i] eq '1';
                push @xs, $i if $mask[$i] eq 'X';
            }

            for my $v ( variations_with_repetition( [ 0, 1 ], scalar @xs ) ) {
                for my $i ( 0 .. $#xs ) {
                    $bin[ $xs[$i] ] = @$v[$i];
                }

                $memory{ oct( "0b" . join( '', @bin ) ) } = $val;
            }
        }
    }

    sum values %memory;
}

say part1;    # 10885823581193
say part2;    # 3816594901962

__DATA__
mask = 000000000000000000000000000000X1001X
mem[42] = 100
mask = 00000000000000000000000000000000X0XX
mem[26] = 1
