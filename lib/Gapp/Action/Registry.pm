package Gapp::Action::Registry;

use Moose;
use MooseX::SemiAffordanceAccessor;
use MooseX::StrictConstructor;

use MooseX::Types::Moose qw( Object HashRef );

has 'actions' => (
    is => 'bare',
    isa => HashRef,
    default => sub { { } },
    traits => [ qw( Hash )],
    handles => {
        _set_action => 'set',
        actions => 'values',
        action => 'get',
        action_list => 'keys',
        has_action => 'exists',
    }
);

sub add_action {
    my ( $self, $action ) = @_;
    
    
    $action = Gapp::Action->new( $action ) if ! is_Object($action);
    $self->_set_action( $action->name, $action );
}

sub perform {
    my ( $self, $action, @args ) = @_;
    
    $self->meta->throw_error( qq[action ($action) does not exist] )
        if ! $self->has_action( $action );
        
    $self->action( $action )->perform( $self, @args );
}



no Moose;
__PACKAGE__->meta->make_immutable;

1;
