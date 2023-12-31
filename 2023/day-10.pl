use v5.38;
no warnings 'experimental';
use experimental qw/builtin/;
use builtin      qw/indexed/;
use Path::Tiny;
use FindBin;
use Time::HiRes qw/time/;
use Data::Dump 'dump';

sub get_input {
    my @grid;
    my @lines = path( $FindBin::Bin, 'input', 'day-10-input-test2.txt' )
      ->lines( { chomp => 1 } );
    my %mapping = (
        '|' => 'ns',
        '-' => 'ew',
        L   => 'ne',
        J   => 'nw',
        7   => 'sw',
        F   => 'se',
        S   => 'S',
        '.' => '.'
    );
    push @grid, [ map { $mapping{$_} } split // ] for @lines;
    @grid;
}

sub is_connected ( $direction, $current, $next_coords, @grid ) {
    my $next = $grid[ $next_coords->[0] ][ $next_coords->[1] ];
    return 0 if not $next or $next eq '.';
    my $this = $grid[ $current->[0] ][ $current->[1] ];
    return 0 if not $this;
    return 0 if $this !~ /$direction/;
    return 1 if $next eq 'S';
    my %opposite = qw/n s s n e w w e/;
    return 0 if $next !~ $opposite{$direction};
    return 1;
}

sub find_start (@grid) {
    for my ( $y, $row ) ( indexed @grid ) {
        for my ( $x, $tile ) ( indexed @$row ) {
            return [ $y, $x ] if $tile eq 'S';
        }
    }
}

sub get_next_tile ( $current, $dir, @grid ) {
    my %directions
      = ( n => [ -1, 0 ], s => [ 1, 0 ], e => [ 0, 1 ], w => [ 0, -1 ] );
    my $delta  = $directions{$dir};
    my $coords = [ $current->[0] + $delta->[0], $current->[1] + $delta->[1] ];
    my $tile   = $grid[ $coords->[0] ][ $coords->[1] ];
    ( $coords, $tile );
}

sub solve_01 (@grid) {
    my %loop;
    my $current    = find_start @grid;
    my @directions = qw/n s e w/;
    my %opposite   = qw/n s s n e w w e/;
    my ( $last_dir, $steps ) = ( 0, 0 );

    $loop{ join ',', $current->[0], $current->[1] }++;

    for my $dir (@directions) {
        my ( $next_coords, $tile ) = get_next_tile $current, $dir, @grid;
        next if $tile eq '.';
        if ( $tile =~ /$opposite{$dir}/ ) {
            ++$steps;
            $loop{ join ',', $current->[0], $current->[1] }++;
            $current  = $next_coords;
            $last_dir = $dir;
            last;
        }
    }

    while (1) {
        for my $dir (@directions) {
            next if $dir eq $opposite{$last_dir};
            my ( $next_coords, $tile ) = get_next_tile $current, $dir, @grid;
            if ( is_connected $dir, $current, $next_coords, @grid ) {
                ++$steps;
                return ( $steps / 2, \%loop ) if $tile eq 'S';
                $loop{ join ',', $current->[0], $current->[1] }++;
                $current  = $next_coords;
                $last_dir = $dir;
                last;
            }
        }
    }
}

sub is_in_loop ( $y, $x, %loop ) {
    my $key = join ',', $y, $x;
    exists $loop{$key} ? 1 : 0;
}

sub solve_02 ( $grid, $loop ) {
    my @grid   = @$grid;
    my %loop   = %$loop;
    my $sum    = 0;
    my $inside = 0;

    my $start = find_start @grid;
    if ( is_in_loop $start->[0] - 1, $start->[1], %loop ) {
        $grid[ $start->[0] ][ $start->[1] ] = 'Sn';
    }

    for my ( $y, $row ) ( indexed @grid ) {
        for my ( $x, $tile ) ( indexed @$row ) {
            if ( is_in_loop( $y, $x, %loop ) and $tile =~ /[sn]/ ) {
                $inside = $inside ? 0 : 1;
                next;
            }
            $sum++ if $inside;
        }
    }

    $sum;
}

my $start = time();
my @grid  = get_input;

my ( $sum, $loop ) = solve_01 @grid;
say $sum;

say solve_02 \@grid, $loop;
printf( "Time: %0.04f s\n", time() - $start );

# |, FJ, L7 flip the inside boolean, while LJ and F7 do not.
# Crossings are path fragments that match |, F-*J or L-*7.
