package Gapp::Image;

use Moose;
use MooseX::SemiAffordanceAccessor;

extends 'Gapp::Widget';

has '+class' => (
    default => 'Gtk2::Image',
);

has 'stock' => (
    is => 'rw',
    isa => 'ArrayRef',
    default => sub { [ ] },
);

1;



__END__

=pod

=head1 NAME

Gapp::Image - Image Widget

=head1 OBJECT HIERARCHY

=over 4

=item L<Gapp::Widget>

=item +-- L<Gapp::Image>

=back

=head1 PROVIDED ATTRIBUTES

=over 4

=item B<stock>

=over 4

=item isa ArrayRef

=back

=back

=head1 AUTHORS

Jeffrey Ray Hallock E<lt>jeffrey.hallock at gmail dot comE<gt>

=head1 COPYRIGHT & LICENSE

    Copyright (c) 2011 Jeffrey Ray Hallock.

    This program is free software; you can redistribute it and/or
    modify it under the same terms as Perl itself.

=cut

