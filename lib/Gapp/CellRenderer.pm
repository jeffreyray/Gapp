package Gapp::CellRenderer;

use Moose;
use MooseX::LazyRequire;
use MooseX::SemiAffordanceAccessor;

extends 'Gapp::Widget';

has 'property' => (
    is => 'rw',
    isa => 'Str',
    lazy_required => 1,
);

1;


__END__

=pod

=head1 NAME

Gapp::CellRenderer - Cell Renderer Widget

=head1 OBJECT HIERARCHY

=over 4

=item L<Gapp::Widget>

=item +-- L<Gapp::CellRenderer>

=back

=head1 PROVIDED ATTRIBUTES

=over 4

=item B<property>

=back

=head1 AUTHORS

Jeffrey Ray Hallock E<lt>jeffrey.hallock at gmail dot comE<gt>

=head1 COPYRIGHT & LICENSE

    Copyright (c) 2011 Jeffrey Ray Hallock.

    This program is free software; you can redistribute it and/or
    modify it under the same terms as Perl itself.

=cut