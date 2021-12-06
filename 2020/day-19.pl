use strict;
use warnings;
use v5.30;
use Path::Tiny;

my @input = split /\n\n/, path('input/day-19-input.txt')->slurp;

my %rules;
for ( split /\n/, $input[0] ) {
    my @rule = split / /;
    ( my $k = shift @rule ) =~ s/://;
    @rule = ( '(', @rule, ')' ) if /\|/;
    $rules{$k} = \@rule;
}

my @temp;
make_rule(0);
( my $rule = join '', @temp ) =~ s/"//g;
say scalar grep /^$rule$/, split /\n/, $input[1];

sub make_rule {
    /^\d+$/ ? make_rule($_) : push @temp, $_ for $rules{ $_[0] }->@*;
}
