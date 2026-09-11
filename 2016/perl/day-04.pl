use v5.42.0;
open my $fh, '<', '../input/day-04.txt' or die $!;
my $sum = 0;
my $id;

sub rotate ( $text, $key ) {
    $text =~ s/([a-z])/
        chr((ord($1) - ord('a') + $key%26) % 26 + ord('a'))
        /gex;
    return $text;
}

while (<$fh>) {
    m/^(.*)-(\d*)\[(.*)\]$/ or die;
    my %count;
    map { $count{$_}++ if m/[a-z]/ } split //, $1;
    my @chars    = sort { $count{$b} <=> $count{$a} || $a cmp $b } keys %count;
    my $checksum = join '', @chars[ 0 .. 4 ];
    if ( $3 eq $checksum ) {
        $sum += $2;
        $id = $2 if grep {/north/} rotate $1, $2;
    }
}

say 'Part 1: ', $sum;
say 'Part 2: ', $id;
