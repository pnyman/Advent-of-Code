use v5.38;
use Path::Tiny;
use Array::Utils qw/intersect/;
use List::Util   qw/sum/;
use FindBin;
use Time::HiRes qw/time/;
my $start = time();

my @input = path( $FindBin::Bin, 'input', 'day-04-input.txt' )
  ->lines( { chomp => 1 } );

my %cards;
my $i = 0;
for ( map { ( split /:/ )[1] } @input ) {
    my ( $winning, $numbers ) = split /\|/;
    my @w = split ' ', $winning;
    my @a = split ' ', $numbers;
    $cards{ ++$i } = { 'wins' => scalar intersect( @w, @a ), 'number' => 1 };
}

sub solve_01 {
    sum map { int 2**( -1 + $_->{wins} ) } values %cards;
}

sub solve_02 {
    for my $i ( 1 .. keys %cards ) {
        for my $j ( 1 .. $cards{$i}{wins} ) {
            $cards{ $i + $j }{number} += $cards{$i}{number};
        }
    }
    sum map { $_->{number} } values %cards;
}

say solve_01;
say solve_02;

printf( "Execution Time: %0.04f s\n", time() - $start );
