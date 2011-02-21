package Gapp::Container;

use Moose;
use MooseX::SemiAffordanceAccessor;
use MooseX::Types::Moose qw( ArrayRef );

extends 'Gapp::Widget';

# the contents of the widget
has 'content' => (
    is => 'ro',
    isa => ArrayRef,
    default => sub { [ ] },
);

sub add {
    my ( $self, $child ) = @_;
    
    $child->set_parent( $self );
    $child->set_layout( $self->layout ) if $self->has_layout;
    $self->layout->pack_widget( $child, $self);
}

#sub INITIALIZE_GTK_WIDGET {
#    $self->add( $_ ) for @{$self->content};
#}

after '_build_gtk_widget' => sub {
    my $self = shift;
    $self->add( $_ ) for @{$self->content};
};


1;
