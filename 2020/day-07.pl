use strict;
use warnings;
use Path::Tiny;

my %bags =
  map { make_key( $_->[0] ) => make_value( $_->[1] ) }
  map { [ split /contain/, s/bags|\.//gr ] }
  split /\n/, path('input/day-07-input.txt')->slurp;

sub make_key {
    local $_ = shift;
    s/^\s*|\s*$//g;
    s/\s+/-/gr;
}

sub make_value {
    [ map { s/\d+//g; make_key($_) } split /,/, shift ]
}


my %bagset;

sub find_shiny_gold {
    my $child = shift // 'shiny-gold';
    for ( keys %bags ) {
        if ( grep /$child/, $bags{$_}->@* ) {
            find_shiny_gold($_);
            $bagset{$_}++;
        }
    }
}

find_shiny_gold;
print scalar keys %bagset, "\n";

# 252
