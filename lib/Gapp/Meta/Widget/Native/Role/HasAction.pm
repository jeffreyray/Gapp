package Gapp::Meta::Widget::Native::Role::HasAction;

use Moose::Role;
use MooseX::SemiAffordanceAccessor;

use MooseX::Types::Moose qw( Undef );
use Gapp::Types qw( GappActionOrArrayRef );

has 'action' => (
    is => 'rw',
    isa => GappActionOrArrayRef|Undef,
);



1;