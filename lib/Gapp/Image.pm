package Gapp::Image;

use Moose;
use MooseX::SemiAffordanceAccessor;

extends 'Gapp::Widget';

has '+class' => (
    default => 'Gtk2::Image',
);

has 'stock' => (
    is => 'rw',
    isa => 'ArrayRef',
    default => sub { [ ] },
);

1;
