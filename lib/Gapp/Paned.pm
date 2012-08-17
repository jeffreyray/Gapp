package Gapp::Paned;

use Moose;
use MooseX::SemiAffordanceAccessor;

extends 'Gapp::Container';

has '+gclass' => (
    default => 'Gtk2::Paned',
);

has 'resize1' => (
    is => 'rw',
    isa => 'Bool',
    default =>  0,
);

has 'shrink1' => (
    is => 'rw',
    isa => 'Bool',
    default => 1,
);

has 'resize2' => (
    is => 'rw',
    isa => 'Bool',
    default =>  1,
);

has 'shrink2' => (
    is => 'rw',
    isa => 'Bool',
    default => 1,
);


sub BUILDARGS {
    my $class = shift;
    my %args = @_ == 1 && is_HashRef( $_[0] ) ? %{$_[0]} : @_;
    
    for my $att ( qw(max_position min_position position position_set) ) {
        $args{properties}{$att} = delete $args{$att} if exists $args{$att};
    }
    
    __PACKAGE__->SUPER::BUILDARGS( %args );
}

1;


__END__

=pod

=head1 NAME

Gapp::Paned - Box widget

=head1 OBJECT HIERARCHY

=over 4

=item L<Gapp::Widget>

=item +-- L<Gapp::Container>

=item ....+-- L<Gapp::Paned>

=back

=head1 DELEGATED PROPERTIES

=over 4

=item max_position

=item min_position

=item position

=item position_set

=back

=head1 AUTHORS

Jeffrey Ray Hallock E<lt>jeffrey.hallock at gmail dot comE<gt>

=head1 COPYRIGHT & LICENSE

    Copyright (c) 2011-2012 Jeffrey Ray Hallock.

    This program is free software; you can redistribute it and/or
    modify it under the same terms as Perl itself.

=cut