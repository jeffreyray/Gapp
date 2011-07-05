package Gapp::FileChooserDialog;

use Moose;
use MooseX::SemiAffordanceAccessor;
use MooseX::Types::Moose qw( ArrayRef );

extends 'Gapp::Dialog';

has '+class' => (
    default => 'Gtk2::FileChooserDialog',
);

has '+gtk_widget' => (
    handles => ['run'],
);

has 'action' => (
    is => 'rw',
    isa => 'Str',
    default => 'open',
);

has '+parent' => (
    is => 'rw',
    isa => 'Maybe[Object]',
    default => undef,
);

has 'filters' => (
    isa => 'ArrayRef',
    default => sub { [] },
    traits => [qw( Array )],
    handles => {
        add_filter => 'push',
        filters => 'elements',
    }
);



before '_build_gtk_widget' => sub {
    my $self = shift;
    $self->set_args( [ $self->properties->{title} ? $self->properties->{title} : '' ,
                      $self->parent ? $self->parent->gtk_widget : undef,
                      $self->action ] );
};
    


1;

__END__

=pod

=head1 NAME

Gapp::FileChooserDialog - Dialog Widget

=head1 OBJECT HIERARCHY

=over 4

=item L<Gapp::Widget>

=item +-- L<Gapp::Container>

=item ....+-- L<Gapp::Window>

=item ........+-- L<Gapp::Dialog>

=item ............+-- L<Gapp::FileChooserDialog>

=back

=head1 PROVIDED ATTRIBUTES

=over 4

=item B<action>

=over 4

=item isa Str

=back

=back

=item B<filters>

=over 4

=item isa Array

=back

=back

=head1 AUTHORS

Jeffrey Ray Hallock E<lt>jeffrey.hallock at gmail dot comE<gt>

=head1 COPYRIGHT & LICENSE

    Copyright (c) 2011 Jeffrey Ray Hallock.

    This program is free software; you can redistribute it and/or
    modify it under the same terms as Perl itself.

=cut