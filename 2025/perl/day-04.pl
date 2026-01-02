use v5.38;
use Path::Tiny;
use List::Util qw(first max);
use Data::Dump;

my $input = '../input/day-04-input.txt';

sub get_input {
    map [ map tr/@./10/r, split // ], path($input)->lines( { chomp => 1 } );
}

sub has_roll ( $grid, $y, $x ) {
    0 <= $y <= $#$grid
      and 0 <= $x <= $#{ $grid->[$y] }
      and $grid->[$y][$x];
}

sub check_adjacent ( $grid, $y, $x ) {
    return 0 if not $grid->[$y][$x];
    my $sount;
    for my $yy ( $y - 1 .. $y + 1 ) {
        for my $xx ( $x - 1 .. $x + 1 ) {
            next if $yy == $y && $xx == $x;
            return 0 if has_roll($grid, $yy, $xx) and ++$sount > 3;
        }
    }
    1;
}

sub part_1 {
    my @grid = get_input;
    my $count;
    for my $y ( keys @grid ) {
        for my $x ( keys $grid[$y]->@* ) {
            ++$count if check_adjacent \@grid, $y, $x;
        }
    }
    say $count;
}

sub part_2 {
    my @grid = get_input;
    my $count;

    while (1) {
        my @mask;

        for my $y ( keys @grid ) {
            for my $x ( keys $grid[$y]->@* ) {
                check_adjacent(\@grid, $y, $x) and push @mask, [ $y, $x ];
            }
        }

        last unless @mask;
        $count += @mask;
        undef $grid[ @$_[0] ][ @$_[1] ] for @mask;
    }
    say $count;
}

# dd get_input;

part_1;
part_2;
