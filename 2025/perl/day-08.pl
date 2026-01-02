use v5.38;
use Path::Tiny;
use List::Util qw(sum);
use Graph::Undirected;
use Data::Dump;

my $input = '../input/day-08-input.txt';

sub get_input {
    map [ split /,/ ], path($input)->lines( { chomp => 1 } );
}

sub distance ( $p1, $p2 ) {
    ## no need to square it
    sum map { ( $p1->[$_] - $p2->[$_] )**2 } 0 .. 2;
}

sub sort_edges (@nodes) {
    my @edges;

    for my $i ( 0 .. $#nodes - 1 ) {
        for my $j ( $i + 1 .. $#nodes ) {
            my $d = distance( $nodes[$i], $nodes[$j] );
            push @edges, [ $d, $nodes[$i], $nodes[$j] ];
        }
    }

    [
        map  { [ join( '-', $_->[1]->@* ), join( '-', $_->[2]->@* ) ] }
        sort { $a->[0] <=> $b->[0] } @edges
    ];
}

sub part_1 ($edges) {
    my $g = Graph::Undirected->new;
    $g->add_edges( @$edges[ 0 .. 999 ] );
    my @s = sort { @$b <=> @$a } $g->connected_components;
    say @{ $s[0] } * @{ $s[1] } * @{ $s[2] };
}

sub part_2 ( $edges, $nr_boxes ) {
    my $g    = Graph::Undirected->new;
    my %seen = ();

    for my $edge (@$edges) {
        $g->add_edges($edge);

        $seen{ $edge->[0] } = 1;
        $seen{ $edge->[1] } = 1;
        next if keys %seen < $nr_boxes;

        if ( $g->connected_components == 1 ) {
            my ($x1) = split /-/, $edge->[0];
            my ($x2) = split /-/, $edge->[1];
            say $x1 * $x2;
            return;
        }
    }
}

my @input = get_input;
my $edges = sort_edges(@input);

part_1 $edges;                  # 62186
part_2 $edges, scalar @input;   # 8420405530
