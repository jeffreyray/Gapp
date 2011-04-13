package Gapp::Form::Context;

use Moose;
use MooseX::StrictConstructor;
use MooseX::SemiAffordanceAccessor;

use Gapp::Form::Context::Node;

has 'accessor' => (
    is => 'rw',
    isa => 'CodeRef|Undef',
);

has 'reader_prefix' => (
    is => 'rw',
    isa => 'Str'
);

has 'writer_prefix' => (
    is => 'rw',
    isa => 'Str'
);

has 'nodes' => (
    is => 'rw',
    isa => 'HashRef',
    traits => [qw( Hash )],
    default => sub { { } },
    handles => {
        get_node => 'get',
        set_node => 'set',
    }
);


# returns a list of default values to use when creating a new node
sub _defaults {
    my $self = shift;
    my @defaults;
    push @defaults, reader_prefix => $self->reader_prefix, if defined $self->reader_prefix;
    push @defaults, writer_prefix => $self->writer_prefix, if defined $self->writer_prefix;
    push @defaults, accessor => $self->accessor, if defined $self->accessor;
    return @defaults;
}

# create a new node
sub add_node {
    my ( $self, $name, $content, @args ) = @_;
    my @defaults = $self->_defaults;

    my $node = Gapp::Form::Context::Node->new( content => $content, @defaults, @args );
    $self->set_node( $name, $node );
    return $node;
}

# used to lookup the value of an attribute
sub lookup {
    my ( $self, $path ) = @_;
    $self->meta->throw_error( 'you must supply a path' ) if ! $path;
    
    my ( $name, $attr ) = split /\./, $path;
    my $node = $self->get_node( $name );
    $node->lookup( $attr );
}

# used to set the value of an attribute
sub modify {
    my ( $self, $path, $value ) = @_;
    $self->meta->throw_error( 'you must supply a path' ) if ! $path;
    $self->meta->throw_error( 'you must supply a value' ) if @_ <= 2;
    
    my ( $name, $attr ) = split /\./, $path;
    my $node = $self->get_node( $name );
    $node->modify( $attr, $value );
    # $self->_value_changed( $path, $value ) if ! $self->in_update( $path );
}

sub update_from_stash {
    my ( $self, $stash ) = @_;
    
    for my $path ( $stash->elements ) {
        
        my $value = $stash->fetch( $path );
        
        # $self->set_in_update( $path, 1 );
        $self->modify( $path, $value );
        # $self->set_in_update( $path, 0 );
    }
}



1;
