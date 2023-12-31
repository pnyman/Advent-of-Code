use v5.38;
no warnings 'experimental';
use experimental qw/builtin/;
use builtin      qw/indexed/;
use Path::Tiny;
use FindBin;
use Time::HiRes qw/time/;
use Data::Dump 'dump';

sub get_input {
    my @lines = path( $FindBin::Bin, 'input', 'day-12-input-test.txt' )
      ->lines( { chomp => 1 } );
    map { [ $_->[0], [ split /,/, $_->[1] ] ] } map { [ split(' ', $_) ] } @lines; 
}

sub make_regex ($nums) {
    my @a = map { "[#?]{$_}" } @$nums;
    $a[0] = '(?<!(\#)' . $a[0] . ')';
    my $s = join '[.?]+', @a;
    # my $s = join '[.?]+', map { "[#?]{$_}" } @$nums;
    # $s =~ s/\?//;
    qr /$s/;
}

sub solve_01 (@data) {
        my $sum = 0;
    for my $d (@data) {
        my $re = make_regex $d->[1]; 
        1 while $d->[0] =~ /$re(?{++$sum})(?!)/;
    }
        $sum;
}


# $_ = 'x###xxxxxxxx';
# my $pat = qr/^x*#{3}x+?x{2}x+?x{1}x*$/;
# say $1 while /($pat)/g;

# 1 while /$pat(?{print $& . ' '})(?!)/;

# my $n;
# 1 while /$pat(?{++$n})(?!)/;
# say $n;


# # strängen vi vill matcha på
# my $s = '.??..??...?##.'; 
# # vi vill finna delsträngar av # eller ?,
# # skrivet som [#?], med längden 1, 1 och 3,
# # med minst ett . eller ? ([.?]+) emellan
# my $re = qr/[#?]{1} [.?]+ [#?]{1} [.?]+ [#?]{3}/x; # x = ignorera blanksteg
# $n = 0;
# # inkrementera $n för varje match
# 1 while $s =~ /$re(?{++$n})(?!)/;
# say $n;

my $s = '?###????????';
my $re = qr/(?<!(\#)[#?]{3}) ([.?]+) ([#?]{2}) ([.?]+) ([#?]{1})/x; # x = ignorera blanksteg
my $n = 0;
1 while $s =~ /$re(?{++$n})(?!)/;
# 1 while $s =~ /$re(?{say $1 . '[' . $2 . ']' . $3 . '[' . $4 . ']' . $5})(?!)/;
say $n;


$s = '???????';
$re = qr/[#?]{2} [.?]+ [#?]{1}/x; # x = ignorera blanksteg
$n = 0;
1 while $s =~ /$re(?{++$n})(?!)/;
say $n;




my $start = time();
my @data  = get_input;
say solve_01 @data;
printf( "Time: %0.04f s\n", time() - $start );
