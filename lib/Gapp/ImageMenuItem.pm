package Gapp::ImageMenuItem;

use Moose;
use MooseX::StrictConstructor;
use MooseX::SemiAffordanceAccessor;

extends 'Gapp::MenuItem';
with 'Gapp::Meta::Widget::Native::Role::HasIcon';

has '+gclass' => (
    default => 'Gtk2::ImageMenuItem',
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

=head2 Roles

=over 4

=item L<Gapp::Meta::Widget::Native::Role::HasIcon>

=back

=head1 AUTHORS

Jeffrey Ray Hallock E<lt>jeffrey.hallock at gmail dot comE<gt>

=head1 COPYRIGHT & LICENSE

    Copyright (c) 2011-2012 Jeffrey Ray Hallock.

    This program is free software; you can redistribute it and/or
    modify it under the same terms as Perl itself.

=cut