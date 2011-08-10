package Gapp::SpinButton;

use Moose;
use MooseX::SemiAffordanceAccessor;

extends 'Gapp::Entry';

has '+class' => (
    default => 'Gtk2::SpinButton',
);

has range => (
    is => 'rw',
    isa => 'ArrayRef',
    default => sub{ [0,999] },
);

has step => (
    is => 'rw',
    isa => 'Num',
    default => 1,
);

has page => (
    is => 'rw',
    isa => 'Maybe[Num]',
);

has '+constructor' => (
    default => 'new_with_range',
);

sub BUILDARGS {
    my $class = shift;
    my %args = @_ == 1 && is_HashRef( $_[0] ) ? %{$_[0]} : @_;
    
    if ( exists $args{digits} ) {
        $args{properties}{digits} = $args{digits};
        delete $args{digits};
    }
    if ( exists $args{climb_rate} ) {
        $args{properties}{climb_rate} = $args{climb_rate};
        delete $args{climb_rate};
    }
    __PACKAGE__->SUPER::BUILDARGS( %args );
}

before '_construct_gtk_widget' => sub {
    my ( $self ) = @_;
    $self->set_args( [ @{ $self->range }, $self->step ]);
};

# returns the value of the widget
sub get_field_value {
    $_[0]->gtk_widget->get_value;
}

sub set_field_value {
    my ( $self, $value ) = @_;
    $self->gtk_widget->set_value( defined $value ? $value : 0 );
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

Gapp::SpinButton - RadioButton Widget

=head1 OBJECT HIERARCHY

=over 4

=item L<Gapp::Widget>

=item +-- L<Gapp::Button>

=item ....+-- L<Gapp::RadioButton>

=back

=head1 AUTHORS

Jeffrey Ray Hallock E<lt>jeffrey.hallock at gmail dot comE<gt>

=head1 COPYRIGHT & LICENSE

    Copyright (c) 2011 Jeffrey Ray Hallock.

    This program is free software; you can redistribute it and/or
    modify it under the same terms as Perl itself.

=cut


