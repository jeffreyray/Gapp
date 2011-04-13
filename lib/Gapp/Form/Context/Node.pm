package Gapp::Form::Context::Node;

use Moose;
use MooseX::StrictConstructor;
use MooseX::SemiAffordanceAccessor;

has 'content' => (
    is => 'rw',
);

has 'accessor' => (
    is => 'rw',
    isa => 'CodeRef|Undef',
);

has 'reader_prefix' => (
    is => 'rw',
    isa => 'Str',
    default => '',
);

has 'writer_prefix' => (
    is => 'rw',
    isa => 'Str',
    default => '',
);


sub lookup {
    my ( $self, $attr ) = @_;
    $self->meta->throw( 'you did not supply an attribute to lookup' ) if ! $attr;
    
    if ( $self->accessor ) {
        return $self->accessor->( $self->content, $attr );
    }
    else {
        my $method = $self->reader_prefix . $attr;
        return $self->content->$method;
    }
}

sub modify {
    my ( $self, $attr, $value ) = @_;
    $self->meta->throw( 'you did not supply an attribute to lookup' ) if ! $attr;
    $self->meta->throw_error( 'you must supply a value' ) if @_ <= 2;
    
    if ( $self->accessor ) {
        return $self->accessor->( $self->content, $attr, $value );
    }
    else {
        my $method = $self->writer_prefix . $attr;
        return $self->content->$method( $value );
    }
}

1;
