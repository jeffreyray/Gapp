package Gapp::TimeEntry;

use Moose;
use MooseX::SemiAffordanceAccessor;

use Gapp::Gtk2::DateEntry;

extends 'Gapp::Entry';
with 'Gapp::Meta::Widget::Native::Trait::FormField';

has '+class' => (
    default => 'Gapp::Gtk2::TimeEntry',
);


sub BUILDARGS {
    my $class = shift;
    my %args = @_ == 1 && is_HashRef( $_[0] ) ? %{$_[0]} : @_;
    
    if ( exists $args{value} ) {
        $args{properties}{value} = $args{value};
        delete $args{value};
    }

    __PACKAGE__->SUPER::BUILDARGS( %args );
}

# returns the value of the widget
sub get_field_value {
    $_[0]->gtk_widget->get_value;
}

sub set_field_value {
    my ( $self, $value ) = @_;
    $self->gtk_widget->set_value( $value );
}

sub _connect_changed_handler {
    my ( $self ) = @_;

    $self->gtk_widget->signal_connect (
      'value-changed' => sub { $self->_widget_value_changed },
    );
}


1;


__END__

=pod

=head1 NAME

Gapp::TimeEntry - TimeEntry Widget

=head1 OBJECT HIERARCHY

=over 4

=item L<Gapp::Widget>

=item +-- L<Gapp::Entry>

=item ----+-- L<Gapp::TimeEntry>

=back

=head1 DELEGATES TO GTK

=head2 Attributes

=over 4

=item B<value>

=back 

=head1 AUTHORS

Jeffrey Ray Hallock E<lt>jeffrey.hallock at gmail dot comE<gt>

=head1 COPYRIGHT & LICENSE

    Copyright (c) 2011 Jeffrey Ray Hallock.

    This program is free software; you can redistribute it and/or
    modify it under the same terms as Perl itself.

=cut

