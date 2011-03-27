package Gapp::MenuShell;

use Moose;
use MooseX::SemiAffordanceAccessor;
extends 'Gapp::Container';

has '+class' => (
    default => 'Gtk2::MenuShell',
);

1;


__END__

=pod

=head1 NAME

Gapp::MenuShell - MenuShell Widget

=head1 OBJECT HIERARCHY

=over 4

=item L<Gapp::Widget>

=item +-- L<Gapp::Container>

=item ....+-- L<Gapp::MenuShell>

=item ........+-- L<Gapp::Menu>

=back

=head1 AUTHORS

Jeffrey Ray Hallock E<lt>jeffrey.hallock at gmail dot comE<gt>

=head1 COPYRIGHT & LICENSE

    Copyright (c) 2011 Jeffrey Ray Hallock.

    This program is free software; you can redistribute it and/or
    modify it under the same terms as Perl itself.

=cut