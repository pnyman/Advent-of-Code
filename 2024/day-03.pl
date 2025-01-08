use v5.38;

open my $fh, '<', './input/day-03-input-test.txt', or die $!;

## Part 1
my $result = 0;
while (<$fh>) {
    $result += $1 * $2 while /mul\((\d+),(\d+)\)/g;
}
say $result;
