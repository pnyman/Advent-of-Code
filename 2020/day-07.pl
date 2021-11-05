use strict;
use warnings;
use Path::Tiny;

my %bags =
  map { make_key( $_->[0] ) => make_value( $_->[1] ) }
  map { [ split /contain/, s/bags?|\.//gr ] }
  split /\n/, path('input/day-07-input.txt')->slurp;

sub make_key {
    local $_ = shift;
    s/^\s*|\s*$//g;
    s/\s+/-/gr;
}

sub make_value {
    my $val = shift;
    my @result;
    for my $bag ( split /,/, $val ) {
        $bag =~ s/(\d+)//;
        push @result, { amount => $1, content => make_key($bag) };
    }
    \@result;
}

my %bagset;

sub part_1 {
    my $child = shift // 'shiny-gold';
    for ( keys %bags ) {
        for my $bag ( $bags{$_}->@* ) {
            next unless $child eq $bag->{content};
            part_1($_);
            $bagset{$_}++;
        }
    }
}

my $number_of_bags = 0;

sub part_2 {
    my $bag     = shift // 'shiny-gold';
    my $lastbag = shift // 1;
    for my $key ( keys %bags ) {
        next unless $key eq $bag;
        for my $subbag ( $bags{$bag}->@* ) {
            next unless $subbag->{amount};
            part_2( $subbag->{content}, $subbag->{amount} * $lastbag );
            $number_of_bags += $subbag->{amount} * $lastbag;
        }
    }
}

part_1;
print scalar keys %bagset, "\n";

# 252

part_2;
print $number_of_bags, "\n";

# 35487
