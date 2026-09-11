use 5.42.0;
open my $fh, '<', '../input/day-01.txt';
my ( $floor, $pos );
while ( defined( my $char = getc($fh) ) ) {
    $char eq '(' and $floor++;
    $char eq ')' and $floor--;
    $pos = tell $fh if $floor == -1 and !defined $pos;
}
say "Part 1:  $floor\nPart 2: $pos";
