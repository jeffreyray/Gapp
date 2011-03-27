package Gapp::MenuItem;

use Moose;
use MooseX::SemiAffordanceAccessor;
extends 'Gapp::Bin';

has '+class' => (
    default => 'Gtk2::MenuItem',
);

has '+constructor' => (
    default => 'new_with_label',
);

has '+args' => (
    default => sub { [ '' ] },
);

has 'label' => (
    is => 'rw',
    isa => 'Str',
);


1;


__END__

=pod

=head1 NAME

Gapp::MenuItem - MenuItem Widget

=head1 OBJECT HIERARCHY

=over 4

=item L<Gapp::Widget>

=item L<Gapp::Container>

=item ....+-- L<Gapp::Bin>

=item ........+-- L<Gapp::MenuItem>

=back

=head1 PROVIDED ATTRIBUTES

=over 4

=item B<label>

=over 4

=item isa Str

=back

=back

=head1 AUTHORS

Jeffrey Ray Hallock E<lt>jeffrey.hallock at gmail dot comE<gt>

=head1 COPYRIGHT & LICENSE

    Copyright (c) 2011 Jeffrey Ray Hallock.

    This program is free software; you can redistribute it and/or
    modify it under the same terms as Perl itself.

=cut


