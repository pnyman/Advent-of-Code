use strict;
use warnings;
use v5.12;
use Path::Tiny;
use DDP;

$/ = '';
open my $fh, '<', 'day-04-input.txt';

my @passports;
for (<$fh>) {
    my %temp;
    for (split) {
        my ( $key, $val ) = split /:/;
        $temp{$key} = $val;
    }
    push @passports, \%temp;
}

## part 1

my $valid = 0;
LOOP: for my $p (@passports) {
    exists $p->{$_} or next LOOP for qw(byr ecl eyr hcl hgt iyr pid);
    $valid++;
}
say $valid;

## part 2

$valid = 0;
LOOP: for my $p (@passports) {
    exists $p->{$_} or next LOOP for qw(byr ecl eyr hcl hgt iyr pid);

    next LOOP
      unless ( $p->{byr} =~ /\d{4}/ && 1920 <= $p->{byr} <= 2002 )
      && ( $p->{iyr} =~ /\d{4}/ && 2010 <= $p->{iyr} <= 2020 )
      && ( $p->{eyr} =~ /\d{4}/ && 2020 <= $p->{eyr} <= 2030 )
      && ( $p->{hcl} =~ /^#[0-9a-f]{6}$/ )
      && ( $p->{ecl} =~ /^amb|blu|brn|gry|grn|hzl|oth$/ )
      && ( $p->{pid} =~ /^[0-9]{9}$/ );

    my ( $val, $unit ) = $p->{hgt} =~ /^(\d+)(cm|in)$/;
    next LOOP
      unless ( $val && $unit )
      && ( $unit =~ /^cm|in$/ )
      && ( $unit eq 'cm' ? 150 <= $val <= 193 : 59 <= $val <= 76 );

    $valid++;
}
say $valid;
