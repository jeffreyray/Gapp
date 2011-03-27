package Gapp::ImageMenuItem;

use Moose;
use MooseX::SemiAffordanceAccessor;
extends 'Gapp::MenuItem';

has '+class' => (
    default => 'Gtk2::ImageMenuItem',
);

has 'icon' => (
    is => 'rw',
    isa => 'Str',
);

1;



__END__

=pod

=head1 NAME

Gapp::ImageMenuItem - ImageMenuItem Widget

=head1 OBJECT HIERARCHY

=over 4

=item L<Gapp::Widget>

=item +-- L<Gapp::MenuItem>

=item ....+-- L<Gapp::ImageMenuItem>

=back

=head1 PROVIDED ATTRIBUTES

=over 4

=item B<icon>

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