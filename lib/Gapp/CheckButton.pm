package Gapp::CheckButton;

use Moose;
use MooseX::SemiAffordanceAccessor;

extends 'Gapp::ToggleButton';

has '+class' => (
    default => 'Gtk2::CheckButton',
);

1;
