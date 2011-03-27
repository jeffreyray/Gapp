package Gapp::Dialog;

use Moose;
use MooseX::SemiAffordanceAccessor;
use MooseX::Types::Moose qw( ArrayRef );

extends 'Gapp::Window';

has 'buttons' => (
    is => 'rw',
    isa => ArrayRef,
    default => sub { [ ] },
);

has '+class' => (
    default => 'Gtk2::Dialog',
);

has '+gtk_widget' => (
    handles => ['run'],
);

after '_build_gtk_widget' => sub {
    shift->gtk_widget->vbox->show_all;
};

1;

__END__

=pod

=head1 NAME

Gapp::Dialog - Dialog Widget

=head1 OBJECT HIERARCHY

=over 4

=item L<Gapp::Widget>

=item +-- L<Gapp::Container>

=item ....+-- L<Gapp::Window>

=item ........+-- L<Gapp::Dialog>

=back

=head1 PROVIDED ATTRIBUTES

=over 4

=item B<buttons>

=over 4

=item isa ArrayRef

=back

=back

=head1 DELEGATES TO GTK

=head2 Methods

=over 4

=item B<run>

=back 

=head1 AUTHORS

Jeffrey Ray Hallock E<lt>jeffrey.hallock at gmail dot comE<gt>

=head1 COPYRIGHT & LICENSE

    Copyright (c) 2011 Jeffrey Ray Hallock.

    This program is free software; you can redistribute it and/or
    modify it under the same terms as Perl itself.

=cut