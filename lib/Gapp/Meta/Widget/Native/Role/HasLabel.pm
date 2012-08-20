package Gapp::Meta::Widget::Native::Role::HasLabel;

use Moose::Role;
use MooseX::SemiAffordanceAccessor;

has 'label' => (
    is => 'rw',
    isa => 'Str',
);


1;