package Gapp::SSNEntry;

use Moose;
use MooseX::SemiAffordanceAccessor;

extends 'Gapp::Entry';
with 'Gapp::Meta::Widget::Native::Role::FormField';

has '+gclass' => (
    default => 'Gapp::Gtk2::SSNEntry',
);


sub BUILDARGS {
    my $class = shift;
    my %args = @_ == 1 && is_HashRef( $_[0] ) ? %{$_[0]} : @_;
    
    for my $att ( qw(value) ) {
        $args{properties}{$att} = delete $args{$att} if exists $args{$att};
    }

    __PACKAGE__->SUPER::BUILDARGS( %args );
}

# returns the value of the widget
sub get_field_value {
    $_[0]->gobject->get_value eq '' ? undef : $_[0]->gobject->get_value;
}

sub set_field_value {
    my ( $self, $value ) = @_;
    $self->gobject->set_value( defined $value ? $value : '' );
}


1;


__END__

=pod

=head1 NAME

Gapp::SSNEntry - SSNEntry Widget

=head1 OBJECT HIERARCHY

=over 4

=item L<Gapp::Widget>

=item +-- L<Gapp::Entry>

=item ----+-- L<Gapp::SSNEntry>

=back

=head1 DELEGATES TO GTK

=head2 Attributes

=over 4

=item B<value>

=back 

=head1 AUTHORS

Jeffrey Ray Hallock E<lt>jeffrey.hallock at gmail dot comE<gt>

=head1 COPYRIGHT & LICENSE

    Copyright (c) 2011-2012 Jeffrey Ray Hallock.

    This program is free software; you can redistribute it and/or
    modify it under the same terms as Perl itself.

=cut

