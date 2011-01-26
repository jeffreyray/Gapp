package Gapp::Meta::ActionSet;

use Moose;
use MooseX::SemiAffordanceAccessor;
use MooseX::StrictConstructor;
use MooseX::Method::Signatures;

use MooseX::Types::Moose qw( Object HashRef );

use Gapp::Meta::Action;

has 'actions' => (
    is => 'bare',
    isa => HashRef,
    default => sub { { } },
    traits => [ qw( Hash )],
    handles => {
        _set_action => 'set',
        actions => 'elements',
        action => 'get',
        has_action => 'exists',
    }
);

method add_action ( Str $name, Object|HashRef $action ) {
    $action = Gapp::Meta::Action->new( $action ) if ! is_Object($action);
    $self->_set_action( $name, $action );
}

method perform ( Str $action, @args ) {
    $self->meta->throw_error( qq[action ($action) does not exist] )
        if ! $self->has_action( $action );
        
    $self->action( $action )->perform( @args );
}



no Moose;
__PACKAGE__->meta->make_immutable;

1;
