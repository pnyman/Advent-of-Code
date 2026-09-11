use 5.42.0;
use Digest::MD5 qw(md5 md5_hex md5_base64);

my $input = 'ckczppom';
my $n = -1;
my $digest;

while (1) {
    $n++;
    $digest = md5($input . $n);
    say $digest;
    if (substr($digest, 0, 1) == 0 and
        substr($digest, 1, 1) == 0 and
        substr($digest, 2, 1) < 16) {
        say $n;
        last;
    }
}
