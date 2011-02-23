package Gapp::MenuItem;

use Moose;
use MooseX::SemiAffordanceAccessor;
extends 'Gapp::Bin';

has '+class' => (
    default => 'Gtk2::MenuItem',
);

has '+constructor' => (
    default => 'new_with_label',
);

has '+args' => (
    default => sub { [ '' ] },
);

has 'label' => (
    is => 'rw',
    isa => 'Str',
);


1;
