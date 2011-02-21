package Gapp::Toolbar;

use Moose;
use MooseX::SemiAffordanceAccessor;
extends 'Gapp::Widget';

has '+class' => (
    default => 'Gtk2::Toolbar',
);

1;
