package Gapp::Entry;

use Moose;
use MooseX::SemiAffordanceAccessor;

extends 'Gapp::Widget';
with 'Gapp::Meta::Widget::Native::Trait::FormField';

has '+gclass' => (
    default => 'Gtk2::Entry',
);

sub BUILDARGS {
    my $class = shift;
    my %args = @_ == 1 && is_HashRef( $_[0] ) ? %{$_[0]} : @_;
    
    for my $att ( qw(text xalign width_chars) ) {
        $args{properties}{$att} = delete $args{$att} if exists $args{$att};
    }

    __PACKAGE__->SUPER::BUILDARGS( %args );
}

# returns the value of the widget
sub get_field_value {
    $_[0]->gobject->get_text;
}

sub set_field_value {
    my ( $self, $value ) = @_;
    $self->gobject->set_text( defined $value ? $value : '' );
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

    $self->gobject->signal_connect (
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

=item L<Gapp::Object>

=item +-- L<Gapp::Widget>

=item ....+-- L<Gapp::Entry>

=back

=head2 Roles

=over 4

=item L<Gapp::Meta::Widget::Native::Trait::FormField>

=back

=head1 DELEGATED PROPERTIES

=over 4

=item B<text>

=item B<xalign>

=back 

=head1 AUTHORS

Jeffrey Ray Hallock E<lt>jeffrey.hallock at gmail dot comE<gt>

=head1 COPYRIGHT & LICENSE

    Copyright (c) 2011-2012 Jeffrey Ray Hallock.

    This program is free software; you can redistribute it and/or
    modify it under the same terms as Perl itself.

=cut

