use v5.38;
use Path::Tiny;
use List::Util qw(sum);
use Graph::Undirected;
use Data::Dump;

my $input = '../input/day-08-test.txt';

sub get_input {
    map [ split /,/ ], path($input)->lines( { chomp => 1 } );
}

sub distance ( $a, $b ) {
    my $dx = $a->[0] - $b->[0];
    my $dy = $a->[1] - $b->[1];
    my $dz = $a->[2] - $b->[2];
    $dx * $dx + $dy * $dy + $dz * $dz;
}

sub make_edges (@nodes) {
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
    @{ $s[0] } * @{ $s[1] } * @{ $s[2] };
}

sub part_2 ( $edges, $nr_nodes ) {
    my $g = Graph::Undirected->new;
    my %nodes;

    for my $edge (@$edges) {
        $g->add_edges($edge);

        $nodes{ $edge->[0] } = 1;
        $nodes{ $edge->[1] } = 1;
        next if keys %nodes < $nr_nodes;

        if ( $g->connected_components == 1 ) {
            my ($x1) = split /-/, $edge->[0];
            my ($x2) = split /-/, $edge->[1];
            return $x1 * $x2;
        }
    }
}

my @nodes = get_input;
dd @nodes;
my $edges = make_edges(@nodes);
say part_1 $edges;                   # 62186
say part_2 $edges, scalar @nodes;    # 8420405530
