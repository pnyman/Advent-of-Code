use 5.42.0;
use List::Util qw/min max/;
open(my $fh, '<', '../input/day-02.txt') or die('Cannot open file: $!');

my ($sum1, $sum2);

while(<$fh>) {
    my ($l, $w, $h) = /(\d+)x(\d+)x(\d+)/;
    my $x = $l * $w;
    my $y = $w * $h;
    my $z = $h * $l;
    $sum1 += 2 * ($x + $y + $z) + min($x, $y, $z);
    my $m = $l +$w + $h - max($l, $w, $h);
    $sum2 += 2 * $m + $l * $w * $h;
}

say 'Part 1: ', $sum1;
say 'Part 2: ', $sum2;
