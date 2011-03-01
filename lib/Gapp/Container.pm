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

after '_build_gtk_widget' => sub {
    my $self = shift;
    $self->add( $_ ) for @{$self->content};
};

# pack widgets into container
sub add {
    my ( $self, $child ) = @_;
    
    $child->set_parent( $self );
    $child->set_layout( $self->layout ) if $self->has_layout;
    $self->layout->pack_widget( $child, $self);
}

# return a list of all descendants
sub find_descendants {
    my ( $self, $child ) = @_;
    
    my @descendants;
    
    for my $w ( @{ $self->content } ) {
        push @descendants, $w;
        push @descendants, $w->find_descendants if $w->can( 'find_descendants' );
    }
    
    return @descendants;
}
1;
