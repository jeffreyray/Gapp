package Gapp::RadioButton;

use Moose;
use MooseX::SemiAffordanceAccessor;

extends 'Gapp::CheckButton';

has '+class' => (
    default => 'Gtk2::RadioButton',
);

has 'value' => (
    is => 'rw',
    isa => 'Str',
    default => '',
);

1;
