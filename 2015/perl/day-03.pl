use 5.42.0;
open my $fh, '<', '../input/day-03.txt';

sub advance( $houses, $char ) {
    my %delta = (
        '>' => { x =>  1, y =>  0 },
        '<' => { x => -1, y =>  0 },
        'v' => { x =>  0, y =>  1 },
        '^' => { x =>  0, y => -1 },
    );

    my %next = @$houses[-1]->%*;
    %next = (
        x => $next{x} + $delta{$char}{x},
        y => $next{y} + $delta{$char}{y} );

    push @$houses, \%next;
}

sub count_houses($houses) {
    my %hash;
    for my $house (@$houses) {
        my $key = sprintf '%d|%d', $house->{x}, $house->{y};
        $hash{$key}++;
    }
    scalar keys %hash;
}

my $origin = { x => 0, y => 0 };
my @houses = ($origin);
my @santa  = ($origin);
my @robo   = ($origin);
my $turn   = 0;

while ( defined( my $char = getc($fh) ) ) {
    next unless $char =~ /[<>v^]/;
    advance \@houses, $char;
    advance \@santa,  $char if $turn % 2 == 0;
    advance \@robo,   $char if $turn % 2 == 1;
    $turn++;
}

say 'Part 1: ', count_houses( \@houses );
say 'Part 2: ', count_houses( [ @santa, @robo ] );
