package Gapp::Button;

use Moose;
use MooseX::SemiAffordanceAccessor;

use Gapp::Types qw( GappActionOrArrayRef );
use MooseX::Types::Moose qw( Undef );

extends 'Gapp::Widget';
with 'Gapp::Meta::Widget::Native::Trait::FormField';

has '+class' => (
    default => 'Gtk2::Button',
);

has 'action' => (
    is => 'rw',
    isa => GappActionOrArrayRef|Undef,
);

has 'label' => (
    is => 'rw',
    isa => 'Maybe[Str]',
);

has 'icon' => (
    is => 'rw',
    isa => 'Maybe[Str]',
);

has 'image' => (
    is => 'rw',
    isa => 'Maybe[Gapp::Image]',
);

has 'stock_id' => (
    is => 'rw',
    isa => 'Maybe[Str]',
);

has 'tooltip' => (
    is => 'rw',
    isa => 'Maybe[Str]',
);


before '_construct_gtk_widget' => sub {
    my ( $self ) = @_;

};


sub BUILDARGS {
    my $class = shift;
    my %args = @_ == 1 && is_HashRef( $_[0] ) ? %{$_[0]} : @_;
    
    if ( exists $args{label} && ! $args{args} ) {
        $args{args} = [ $args{label} ];
        $args{constructor} = 'new_with_label';
    }
    
    __PACKAGE__->SUPER::BUILDARGS( %args );
}

1;

# returns the value of the widget
sub get_field_value {
}

sub set_field_value {
}

sub widget_to_stash {

}

sub stash_to_widget {

}



__END__

=pod

=head1 NAME

Gapp::Box - Box widget

=head1 OBJECT HIERARCHY

    Gapp::Widget
    +--Gapp::Container
      +--Gapp::Box

=head2 Roles

=over 4

=item L<Gapp::Meta::Widget::Native::Trait::FormField>

=back

=head1 PROVIDED ATTRIBUTES

=over 4

=item label

=back

=head1 AUTHORS

Jeffrey Ray Hallock E<lt>jeffrey.hallock at gmail dot comE<gt>

=head1 COPYRIGHT & LICENSE

    Copyright (c) 2011 Jeffrey Ray Hallock.

    This program is free software; you can redistribute it and/or
    modify it under the same terms as Perl itself.

=cut