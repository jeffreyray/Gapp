package Gapp::MenuShell;

use Moose;
use MooseX::SemiAffordanceAccessor;
extends 'Gapp::Container';

has '+class' => (
    default => 'Gtk2::MenuShell',
);



1;
