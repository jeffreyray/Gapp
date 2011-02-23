package Gapp::Menu;

use Moose;
use MooseX::SemiAffordanceAccessor;
extends 'Gapp::MenuShell';

has '+class' => (
    default => 'Gtk2::Menu',
);


1;
