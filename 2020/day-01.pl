use strict;
use warnings;
use v5.12;
use Path::Tiny;

my @foo = split /\n/, path('input', 'day-01-input.txt')->slurp;

# part 1

LOOP: for my $i ( 0 .. $#foo - 1 ) {
    for my $j ( $i + 1 .. $#foo ) {
        if ( $foo[$i] + $foo[$j] == 2020 ) {
            say $foo[$i] * $foo[$j];
            last LOOP;
        }
    }
}

# 927684

# part 2

LOOP: for my $i ( 0 .. $#foo - 2 ) {
    for my $j ( $i + 1 .. $#foo - 1 ) {
        for my $k ( $j + 1 .. $#foo ) {
            if ( $foo[$i] + $foo[$j] + $foo[$k] == 2020 ) {
                say $foo[$i] * $foo[$j] * $foo[$k];
                last LOOP;
            }
        }
    }
}

# 292093004
