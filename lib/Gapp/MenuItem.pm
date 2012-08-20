package Gapp::MenuItem;

use Moose;
use MooseX::SemiAffordanceAccessor;

extends 'Gapp::Bin';
with 'Gapp::Meta::Widget::Native::Role::HasAction';
with 'Gapp::Meta::Widget::Native::Role::HasLabel';
with 'Gapp::Meta::Widget::Native::Role::HasMenu';

has '+gclass' => (
    default => 'Gtk2::MenuItem',
);

has '+constructor' => (
    default => 'new_with_label',
);

has '+args' => (
    default => sub { [ '' ] },
);


1;


__END__

=pod

=head1 NAME

Gapp::MenuItem - MenuItem Widget

=head1 OBJECT HIERARCHY

=over 4

=item L<Gapp::Object>

=item +-- L<Gapp::Widget>

=item ....+-- L<Gapp::Container>

=item ........+-- L<Gapp::Bin>

=item ............+-- L<Gapp::MenuItem>

=back

=head2 Roles

=over 4

=item L<Gapp::Meta::Widget::Native::Role::HasAction>

=item L<Gapp::Meta::Widget::Native::Role::HasLabel>

=item L<Gapp::Meta::Widget::Native::Role::HasMenu>

=back

=head1 AUTHORS

Jeffrey Ray Hallock E<lt>jeffrey.hallock at gmail dot comE<gt>

=head1 COPYRIGHT & LICENSE

    Copyright (c) 2011-2012 Jeffrey Ray Hallock.

    This program is free software; you can redistribute it and/or
    modify it under the same terms as Perl itself.

=cut


