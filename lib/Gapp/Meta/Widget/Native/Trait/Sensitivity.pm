package Gapp::Meta::Widget::Native::Trait::Sensitivity;

use Moose::Role;
use MooseX::SemiAffordanceAccessor;

has 'sensitive_func' => (
    is => 'rw',
    isa => 'Maybe[CodeRef]',
);

sub check_sensitivity {
    my ( $self ) = @_;
    return if ! $self->sensitive_func;
    $self->set_sensitive( $self->sensitive_func( $self ) );
}



package Gapp::Meta::Widget::Custom::Trait::Sensitivity;
sub register_implementation { 'Gapp::Meta::Widget::Native::Trait::Sensitivity' };


1;