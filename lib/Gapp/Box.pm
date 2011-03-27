package Gapp::Box;

use Moose;
use MooseX::SemiAffordanceAccessor;

extends 'Gapp::Container';

has '+class' => (
    default => 'Gtk2::Box',
);

sub BUILDARGS {
    my $class = shift;
    my %args = @_ == 1 && is_HashRef( $_[0] ) ? %{$_[0]} : @_;
    
    if ( exists $args{spacing} ) {
        $args{properties}{spacing} = $args{spacing};
        delete $args{spacing};
    }
    if ( exists $args{homogeneous} ) {
        $args{properties}{homogeneous} = $args{homogeneous};
        delete $args{homogeneous};
    }
    
    __PACKAGE__->SUPER::BUILDARGS( %args );
}

1;


__END__

=pod

=head1 NAME

Gapp::Box - Box widget

=head1 OBJECT HIERARCHY

    Gapp::Widget
    +--Gapp::Container
      +--Gapp::Box

=head1 DELEGATED PROPERTIES

=over 4

=item spacing

=item homogeneous

=back

=head1 AUTHORS

Jeffrey Ray Hallock E<lt>jeffrey.hallock at gmail dot comE<gt>

=head1 COPYRIGHT & LICENSE

    Copyright (c) 2011 Jeffrey Ray Hallock.

    This program is free software; you can redistribute it and/or
    modify it under the same terms as Perl itself.

=cut