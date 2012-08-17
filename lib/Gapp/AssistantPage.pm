package Gapp::AssistantPage;

use Moose;
use MooseX::LazyRequire;
use MooseX::SemiAffordanceAccessor;
use MooseX::Types::Moose qw( HashRef );

extends 'Gapp::VBox';

has 'name' => (
    is => 'rw',
    isa => 'Str',
    default => '',
);

has 'title' => (
    is => 'rw',
    isa => 'Str',
    default => '',
);

has 'type' => (
    is => 'rw',
    isa => 'Str',
    default => '',
    lazy_required => 1,
);

has 'icon' => (
    is => 'rw',
    isa => 'Str',
    default => '',
);

has 'num' => (
    is => 'rw',
    isa => 'Int|Undef',
);

# the validator function is valled to determine if the page is complete
# the code-ref should return true for complete, false for not
has 'validator' => (
    is => 'rw',
    isa => 'Maybe[CodeRef]',
);

# call validate to validate the page
sub validate {
    my ( $self ) = shift;
    return if ! $self->validator;
    
    my $valid = $self->validator->( $self );
    
    if ( ! $self->parent ) {
        warn qq[could not mark page ($self) as complete: ] .
             qq[you must add this page to an assistant first];
        return $valid;
    }
    
    $self->parent->gobject->set_page_complete( $self->gobject, $valid );
    return $valid;
}




1;
