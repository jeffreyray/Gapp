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



__END__

=pod

=head1 NAME

Gapp::Container - Container Widget

=head1 OBJECT HIERARCHY

=over 4

=item L<Gapp::Widget>

=item +-- L<Gapp::Container>

=back

=head1 PROVIDED ATTRIBUTES

=over 4

=item B<content>

=over 4

=item isa ArrayRef

=back

=back

=head1 PROVIDED METHODS

=over 4

=item B<find_descendants>

Returns a list of all descendants of this container.

=back 

=head1 AUTHORS

Jeffrey Ray Hallock E<lt>jeffrey.hallock at gmail dot comE<gt>

=head1 COPYRIGHT & LICENSE

    Copyright (c) 2011 Jeffrey Ray Hallock.

    This program is free software; you can redistribute it and/or
    modify it under the same terms as Perl itself.

=cut

