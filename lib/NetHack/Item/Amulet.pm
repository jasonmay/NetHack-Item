package NetHack::Item::Amulet;
use Moose;
extends 'NetHack::Item';
with 'NetHack::Item::Role::Wearable';

use constant type => 'amulet';

__PACKAGE__->meta->make_immutable;
no Moose;

1;

