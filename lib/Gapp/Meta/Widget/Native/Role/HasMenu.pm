package Gapp::Meta::Widget::Native::Role::HasMenu;

use Moose::Role;
use MooseX::SemiAffordanceAccessor;

has 'menu' => (
    is => 'rw',
    isa => 'Maybe[Gapp::Widget]',
);



1;