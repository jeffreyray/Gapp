package Gapp::TextView;

use Moose;
use MooseX::SemiAffordanceAccessor;


extends 'Gapp::Widget';
with 'Gapp::Meta::Widget::Native::Trait::FormField';

use Gapp::TextBuffer;

has '+class' => (
    default => 'Gtk2::TextView',
);

has 'buffer' => (
    is => 'rw',
    isa => 'Maybe[Gapp::TextBuffer]',
);

has 'get_hidden_chars' => (
    is => 'rw',
    isa => 'Bool',
    default => 0,
);

# returns the value of the widget
sub get_field_value {
    my ( $self ) = @_;
    my $buffer = $self->gtk_widget->get_buffer;
    $buffer->get_text( $buffer->get_start_iter, $buffer->get_end_iter, $self->get_hidden_chars );
}

sub set_field_value {
    my ( $self, $value ) = @_;
    my $buffer = $self->gtk_widget->get_buffer;
    $buffer->set_text( defined $value ? $value : '' );
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

    $self->gtk_widget->get_buffer->signal_connect (
      changed => sub { $self->_widget_value_changed },
    );
}

1;


__END__

=pod

=head1 NAME

Gapp::TextView - TextView Widget

=head1 OBJECT HIERARCHY

=over 4

=item L<Gapp::Widget>

=item +-- L<Gapp::TextView>

=back

=head2 Roles

=over 4

=item L<Gapp::Meta::Widget::Native::Trait::FormField>

=back


=head1 PROVIDED ATTRIBUTES

=over 4

=item B<buffer>

=over 4

=item isa: Gapp::TextBuffer|Undef

=item default: undef

=back

Assigned to the TextView upon construction.

=back

=head1 AUTHORS

Jeffrey Ray Hallock E<lt>jeffrey.hallock at gmail dot comE<gt>

=head1 COPYRIGHT & LICENSE

    Copyright (c) 2011 Jeffrey Ray Hallock.

    This program is free software; you can redistribute it and/or
    modify it under the same terms as Perl itself.

=cut

