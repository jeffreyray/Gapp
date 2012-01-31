package Gapp::Entry;

use Moose;
use MooseX::SemiAffordanceAccessor;

extends 'Gapp::Widget';
with 'Gapp::Meta::Widget::Native::Trait::FormField';

has '+class' => (
    default => 'Gtk2::Entry',
);

sub BUILDARGS {
    my $class = shift;
    my %args = @_ == 1 && is_HashRef( $_[0] ) ? %{$_[0]} : @_;
    
    if ( exists $args{text} ) {
        $args{properties}{text} = $args{text};
        delete $args{text};
    }
    if ( exists $args{xalign} ) {
        $args{properties}{xalign} = delete $args{xalign};
    }
    if ( exists $args{width_chars} ) {
        $args{properties}{width_chars} = delete $args{width_chars};
    }
    __PACKAGE__->SUPER::BUILDARGS( %args );
}

# returns the value of the widget
sub get_field_value {
    $_[0]->gtk_widget->get_text;
}

sub set_field_value {
    my ( $self, $value ) = @_;
    $self->gtk_widget->set_text( defined $value ? $value : '' );
}

sub widget_to_stash {
    my ( $self, $stash ) = @_;
    $stash->store( $self->field, $self->get_field_value );
}

sub stash_to_widget {
    my ( $self, $stash ) = @_;
    $self->set_field_value( $stash->fetch( $self->field ) );
}

sub _connect_changed_handler {
    my ( $self ) = @_;

    $self->gtk_widget->signal_connect (
      changed => sub { $self->_widget_value_changed },
    );
}

1;


__END__

=pod

=head1 NAME

Gapp::Entry - Entry Widget

=head1 OBJECT HIERARCHY

=over 4

=item L<Gapp::Widget>

=item +-- L<Gapp::Entry>

=back

=head2 Roles

=over 4

=item L<Gapp::Meta::Widget::Native::Trait::FormField>

=back

=head1 PROVIDED ATTRIBUTES

=over 4

=item B<buttons>

=over 4

=item isa ArrayRef

=back

=back

=head1 DELEGATES TO GTK

=head2 Attributes

=over 4

=item B<text>

=item B<xalign>

=back 

=head1 AUTHORS

Jeffrey Ray Hallock E<lt>jeffrey.hallock at gmail dot comE<gt>

=head1 COPYRIGHT & LICENSE

    Copyright (c) 2011 Jeffrey Ray Hallock.

    This program is free software; you can redistribute it and/or
    modify it under the same terms as Perl itself.

=cut

