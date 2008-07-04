#!/usr/bin/env perl
package NetHack::Item::Armor;
use Moose;
extends 'NetHack::Item';
with 'NetHack::Item::Role::Wearable';

use constant type => "armor";

__PACKAGE__->meta->make_immutable;
no Moose;

1;

