#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;
use NetHack::Item;
use List::Util 'sum';

my %base = (
    slot          => undef,
    quantity      => 1,
    buc           => undef,
    greased       => 0,
    poisoned      => 0,
    erosion1      => 0,
    erosion2      => 0,
    proof         => undef,
    used          => 0,
    eaten         => 0,
    diluted       => 0,
    item          => undef,
    enchantment   => undef,
    generic       => undef,
    specific      => undef,
    recharges     => undef,
    charges       => undef,
    candles       => 0,
    lit           => 0,
    laid          => 0,
    chain         => 0,
    quiver        => 0,
    offhand       => 0,
    wield         => 0,
    offhand_wield => 0,
    wear          => undef,
    price         => 0,
);

my %all_checks = (
    "a long sword" => {
        item => "long sword",
    },
    "the blessed +1 Excalibur" => {
        item        => "Excalibur",
        enchantment => '+1',
        buc         => 'blessed',
    },
    "a - 2 cursed -3 darts" => {
        item        => "darts",
        slot        => 'a',
        buc         => 'cursed',
        enchantment => '-3',
        quantity    => 2,
    },
    "a potion called foo named bar" => {
        item     => "potion",
        generic  => 'foo',
        specific => 'bar',
    },
    "a - a +0 katana (weapon in hand)" => {
        item        => "katana",
        slot        => 'a',
        enchantment => '+0',
        wield       => 1,
    },
    "b - a +0 wakizashi (alternate weapon; not wielded)" => {
        item        => "wakizashi",
        slot        => 'b',
        enchantment => '+0',
        offhand     => 1,
    },
    "b - a +0 wakizashi (wielded in other hand)" => {
        item          => "wakizashi",
        slot          => 'b',
        enchantment   => '+0',
        offhand_wield => 1,
    },
    "p - a partly used candle (lit)" => {
        item => 'candle',
        lit  => 1,
        slot => 'p',
        used => 1,
    },
    "p - a partly used candle" => {
        item => 'candle',
        slot => 'p',
        used => 1,
    },
    "o - a candelabrum (no candles attached)" => {
        item    => 'candelabrum',
        slot    => 'o',
    },
    "o - a candelabrum (1 candle attached)" => {
        item    => 'candelabrum',
        slot    => 'o',
        candles => 1,
    },
    "o - a candelabrum (1 candle, lit)" => {
        item    => 'candelabrum',
        lit     => 1,
        slot    => 'o',
        candles => 1,
    },
    "r - a potion of holy water" => {
        slot => 'r',
        item => 'potion of water',
        buc  => 'holy',
    },
    "r - a potion of unholy water" => {
        slot => 'r',
        item => 'potion of water',
        buc  => 'unholy',
    },
    "r - an uncursed potion of water" => {
        slot => 'r',
        item => 'potion of water',
        buc  => 'uncursed',
    },
);

plan tests => scalar keys %all_checks;

for my $item (sort keys %all_checks) {
    my $checks = { %base, %{ $all_checks{$item} } };

    my $stats = NetHack::Item->extract_stats($item);
    is_deeply($stats, $checks, "'$item'");
}
