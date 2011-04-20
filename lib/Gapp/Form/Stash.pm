package Gapp::Form::Stash;

use Moose;
use MooseX::StrictConstructor;
use MooseX::SemiAffordanceAccessor;


has 'storage' => (
    is => 'bare',
    isa => 'HashRef',
    default => sub { { } },
    traits => [qw( Hash )],
    clearer => 'clear',
    handles => {
        store => 'set',
        fetch => 'get',
        contains => 'exists',
        delete => 'delete',
        elements => 'keys',
    },
    lazy => 1,
);

# if the stash has been modified via the form
has 'modified' => (
    is => 'rw',
    isa => 'Bool',
    default => 0,
);

# if the stash has been updated to reflect the current state of the model
has 'updated' => (
    is => 'rw',
    isa => 'Int',
    default => 0,
);

# if the context has updated the stash
after 'store'  => sub { $_[0]->set_modified(1) unless $_[0]->updated == 2 };
after 'delete' => sub { $_[0]->set_modified(1) unless $_[0]->updated == 2 };


sub update_from_context {
    my ( $self, $cx ) = @_;
    
    for my $field ( $self->elements ) {
        $self->store( $field, $cx->lookup( $field ) );
    }
    
    $self->set_modified( 0 );
    $self->set_updated( 1 );
}




1;
