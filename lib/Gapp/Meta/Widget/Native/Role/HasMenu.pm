package Gapp::Meta::Widget::Native::Role::HasMenu;

use Moose::Role;
use MooseX::SemiAffordanceAccessor;

has 'menu' => (
    is => 'rw',
    isa => 'Maybe[Gapp::Menu]',
);



1;


__END__

=pod

=head1 NAME

Gapp::Meta::Widget::Native::Role::HasMenu - menu attribute for widgets
   
=head1 PROVIDED ATTRIBUTES

=over 4

=item B<menu>

=over 4

=item is rw

=item isa L<Gapp::Menu>|Undef

=back

The L<Gapp::Menu> assigned to the widget.

=back

=head1 AUTHORS

Jeffrey Ray Hallock E<lt>jeffrey.hallock at gmail dot comE<gt>

=head1 COPYRIGHT & LICENSE

    Copyright (c) 2011-2012 Jeffrey Ray Hallock.

    This program is free software; you can redistribute it and/or
    modify it under the same terms as Perl itself.

=cut