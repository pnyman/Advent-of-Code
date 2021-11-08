use strict;
use warnings;
no warnings 'experimental';
use feature 'switch';
use Math::Trig 'deg2rad';
use Path::Tiny;

package ship;
sub new { bless { bearing => 0, x => 0, y => 0 }, shift }

package waypoint;
sub new { bless { x => 10, y => -1 }, shift }

package main;

my @input = map { [ substr( $_, 0, 1 ), substr( $_, 1 ) ] } split /\n/,
  path('input/day-12-input.txt')->slurp;

sub rotate {
    my $wp    = shift;
    my $theta = deg2rad(shift);
    my ( $s, $c ) = ( sin $theta, cos $theta );
    my $x_new = sprintf( '%.0f', $wp->{x} * $c - $wp->{y} * $s );
    my $y_new = sprintf( '%.0f', $wp->{x} * $s + $wp->{y} * $c );
    $wp->{x} = $x_new;
    $wp->{y} = $y_new;
    $wp;
}

sub part1 {
    my @sequence = shift->@*;
    my $ship     = ship->new;

    for (@sequence) {
        my ( $instruction, $value ) = @$_;
        given ($instruction) {
            when ('N') { $ship->{y} -= $value }
            when ('S') { $ship->{y} += $value }
            when ('W') { $ship->{x} -= $value }
            when ('E') { $ship->{x} += $value }
            when ('R') {
                $ship->{bearing} = ( $ship->{bearing} + $value ) % 360
            }
            when ('L') {
                $ship->{bearing} = ( $ship->{bearing} - $value ) % 360
            }
            when ('F') {
                given ( $ship->{bearing} ) {
                    $ship->{x} -= $value when 180;
                    $ship->{x} += $value when 0;
                    $ship->{y} -= $value when 270;
                    $ship->{y} += $value when 90;
                }
            }
        }
    }

    abs( $ship->{x} ) + abs( $ship->{y} );
}

sub part2 {
    my @sequence = shift->@*;
    my $ship     = ship->new;
    my $wp       = waypoint->new;

    for (@sequence) {
        my ( $instruction, $value ) = @$_;
        given ($instruction) {
            when ('N') { $wp->{y} -= $value }
            when ('S') { $wp->{y} += $value }
            when ('W') { $wp->{x} -= $value }
            when ('E') { $wp->{x} += $value }
            when ('R') { $wp = rotate $wp, $value }
            when ('L') { $wp = rotate $wp, -$value }
            when ('F') {
                $ship->{x} += $wp->{x} * $value;
                $ship->{y} += $wp->{y} * $value;
            }
        }
    }

    abs( $ship->{x} ) + abs( $ship->{y} );
}

print part1( \@input ), "\n";    # 1007
print part2( \@input ), "\n";    # 41212
