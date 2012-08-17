package Gapp::Meta::Widget::Native::Role::HasIcon;

use Moose::Role;
use MooseX::SemiAffordanceAccessor;

has 'icon' => (
    is => 'rw',
    isa => 'Maybe[Str]',
);



1;