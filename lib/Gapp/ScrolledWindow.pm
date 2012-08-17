package Gapp::ScrolledWindow;

use Moose;
use MooseX::SemiAffordanceAccessor;

extends 'Gapp::Bin';

has '+gclass' => (
    default => 'Gtk2::ScrolledWindow',
);

has 'policy' => (
    is => 'rw',
    isa => 'Maybe[ArrayRef]',
);

has 'use_viewport' => (
    is => 'rw',
    isa => 'Bool',
    default => 0,
);


1;



__END__

=pod

=head1 NAME

Gapp::Bin - Bin widget

=head1 OBJECT HIERARCHY

=over 4

=item L<Gapp::Widget>

=item +-- L<Gapp::Container>

=item ....+-- L<Gapp::Bin>

=item ........+-- L<Gapp::ScrolledWindow>

=back

=head1 AUTHORS

Jeffrey Ray Hallock E<lt>jeffrey.hallock at gmail dot comE<gt>

=head1 COPYRIGHT & LICENSE

    Copyright (c) 2011-2012 Jeffrey Ray Hallock.

    This program is free software; you can redistribute it and/or
    modify it under the same terms as Perl itself.

=cut