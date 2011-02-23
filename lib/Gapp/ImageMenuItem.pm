package Gapp::ImageMenuItem;

use Moose;
use MooseX::SemiAffordanceAccessor;
extends 'Gapp::MenuItem';

has '+class' => (
    default => 'Gtk2::ImageMenuItem',
);

has 'icon' => (
    is => 'rw',
    isa => 'Str',
);

1;
