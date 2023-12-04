no warnings;

%h = map { $_ => ++$i } qw/one two three four five six seven eight nine/;
$x = join '|', keys %h;

while (<>) {
    @_ = /([0-9])/g;
    $P1 += $_[0] . $_[-1];
    @_ = map { int $_ || $h{$_} } /(?=([0-9]|$x))/g;
    $P2 += $_[0] . $_[-1];
}

print "$P1 $P2";
