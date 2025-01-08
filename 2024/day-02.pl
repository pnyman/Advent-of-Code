use v5.38;

open my $fh, '<', './input/day-02-input.txt', or die $!;
my $safe = 0;

sub is_safe (@arr) {
    my @sorted
      = $arr[0] < $arr[-1]
      ? sort { $a <=> $b } @arr
      : sort { $b <=> $a } @arr;

    for ( 0 .. $#arr ) {
        return 0 if $arr[$_] != $sorted[$_];
    }

    for ( 0 .. $#arr - 1 ) {
        return 0 if not 1 <= abs( $arr[$_] - $arr[ $_ + 1 ] ) <= 3;
    }

    return 1;
}

while (<$fh>) {
    ++$safe if is_safe( split /\s+/ );
}

say $safe;

## Part 2

seek $fh, 0, 0;
$safe = 0;

while (<$fh>) {
    my @arr = split /\s+/;
    ++$safe and next if is_safe(@arr);
    for ( 0 .. $#arr ) {
        my @tmp = @arr;
        splice @tmp, $_, 1;
        ++$safe and last if is_safe @tmp;
    }
}

say $safe;
