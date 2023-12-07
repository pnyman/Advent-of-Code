use v5.38;
use Path::Tiny;
use FindBin;
use List::Util  qw/sum/;
use Time::HiRes qw/time/;

my $start = time();

sub get_input {
    path( $FindBin::Bin, 'input', 'day-07-input.txt' )
      ->lines( { chomp => 1 } );
}

sub cmpfunc {
    return
         ( $a->[0][0] <=> $b->[0][0] )
      || ( $a->[0][1] <=> $b->[0][1] )
      || ( $a->[0][2] <=> $b->[0][2] )
      || ( $a->[0][3] <=> $b->[0][3] )
      || ( $a->[0][4] <=> $b->[0][4] );
}

sub flatten {
    return map { ref eq 'ARRAY' ? @$_ : $_ } @_;
}

sub compute_winnings (@rankings) {
    my $rank;
    @$_ = sort cmpfunc @$_ for @rankings;
    sum map { $_->[1] * ++$rank } flatten @rankings;
}

sub solve ($part) {
    my @input = get_input;
    my %h     = qw/A 14 K 13 Q 12 J 11 T 10/;
    $h{J} = 1 if $part == 2;
    my @rankings;

    for (@input) {
        my ( $hand, $bet ) = split ' ';
        my @hand = map { $h{$_} ? $h{$_} : $_ } split //, $hand;

        my %cards;
        $cards{$_}++ for @hand;
        $_ = join '', values %cards;

        my $type   = 0;
        my $jokers = defined $cards{1} ? $cards{1} : 0;

        if (/5/) {    # five of a kind
            $type = 6;
        }
        elsif (/4/) {    # four of a kind
            $type = 5;
            $type = 6 if $jokers;
        }
        elsif ( /3/ && /2/ ) {    # full house
            $type = 4;
            $type = 6 if $jokers;
        }
        elsif (/3/) {             # three of a kind
            $type = 3;
            $type = 5 if $jokers;
        }
        elsif ( /2/g && /2/g ) {    # two pairs
            $type = 2;
            $type = 4 if $jokers == 1;
            $type = 5 if $jokers == 2;
        }
        elsif (/2/) {               # one pair
            $type = 1;
            $type = 3 if $jokers;
        }
        elsif ($jokers) {           # high card, but one joker
            $type = 1;
        }

        push $rankings[$type]->@*, [ \@hand, $bet ];
    }

    compute_winnings @rankings;
}

say solve(1);
say solve(2);

printf( "Time: %0.04f s\n", time() - $start );

