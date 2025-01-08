use v5.38;

open my $fh, '<', './input/day-01-input.txt', or die $!;

my ( @left, @right, $sum );

while (<$fh>) {
    my ( $first, $second ) = split /\s+/;
    push @left,  $first;
    push @right, $second;
}

@left  = sort { $a <=> $b } @left;
@right = sort { $a <=> $b } @right;

$sum += abs( $left[$_] - $right[$_] ) for 0 .. $#left;
say $sum;

$sum = 0;
for my $n (@left) {
    $sum += $n * scalar grep { $n == $_ } @right;
}
say $sum;
