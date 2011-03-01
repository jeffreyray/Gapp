package Gapp::Form::Context;

use Moose;
use MooseX::SemiAffordanceAccessor;

use Gapp::Form::Context::Node;

has 'nodes' => (
    is => 'rw',
    isa => 'HashRef',
    traits => [qw( Hash )],
    default => sub { { } },
    handles => {
        get_node => 'get',
    }
);

sub add_node {
    my ( $self, $name, @args ) = @_;

    my $node = Gapp::Form::Context::Node->new( @args ? ( content => @args ) : ( ) );
    $self->nodes->{$name} = $node;
}

sub update_widget {
    my ( $self, $w ) = @_;
    
    my $field = $w->field;
    next if ! $field;
    
    my ( $nodename, $attr ) = split /\./, $field;
    my $node = $self->get_node( $nodename );
    
    # add layer of abstraction
    my $o = $node->content;   
    my $value = $o->$attr;
    $w->gtk_widget->set_text( $value );
}

1;
