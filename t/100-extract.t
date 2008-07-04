#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;
use NetHack::Item;
use List::Util 'sum';

my %all_checks = (
    "a long sword" => {
        slot        => undef,
        quantity    => 1,
        buc         => undef,
        greased     => 0,
        poisoned    => 0,
        erosion1    => 0,
        erosion2    => 0,
        proof       => undef,
        used        => 0,
        eaten       => 0,
        diluted     => 0,
        item        => 'long sword',
        enchantment => undef,
        generic     => undef,
        specific    => undef,
    },
    "the blessed +1 Excalibur" => {
        slot        => undef,
        quantity    => 1,
        enchantment => '+1',
        generic     => undef,
        specific    => undef,
    },
    "a - 2 +3 darts" => {
        slot        => 'a',
        quantity    => 2,
        enchantment => '+3',
        generic     => undef,
        specific    => undef,
    },
    "a potion called foo named bar" => {
        slot        => undef,
        quantity    => 1,
        enchantment => undef,
        generic     => 'foo',
        specific    => 'bar',
    },
);

plan tests => sum map { scalar keys %$_ } values %all_checks;

for my $item (keys %all_checks) {
    my $checks = $all_checks{$item};

    my $stats = NetHack::Item->extract_stats($item);
    for my $stat (keys %$checks) {
        is($checks->{$stat}, $stats->{$stat}, "'$item' $stat");
    }
}

