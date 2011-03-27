package Gapp::UIManager;

use Moose;
use MooseX::SemiAffordanceAccessor;
extends 'Gapp::Widget';

use Gapp::ActionGroup;

has '+class' => (
    default => 'Gtk2::UIManager',
);

has 'files' => (
    is => 'rw',
    isa => 'ArrayRef',
    default => sub { [ ] },
);

has 'actions' => (
    is => 'rw',
    isa => 'ArrayRef',
    default => sub { [ ] },
);

has 'action_args' => (
    is => 'rw',
    isa => 'ArrayRef',
    default => sub { [ ] },
);

after _construct_gtk_widget => sub {
    my $self = shift;
   $self->gtk_widget->add_ui_from_file( $_ ) for @{ $self->files };
   $self->_apply_actions_to_gtk_widget;
};

sub _apply_actions_to_gtk_widget {
    my ( $self ) = @_;
    
    my $group = Gapp::ActionGroup->new( actions => [@{$self->actions}], action_args => [@{$self->action_args}] );
    $self->gtk_widget->insert_action_group( $group->gtk_widget, 0 );
}

1;

__END__

=pod

=head1 NAME

Gapp::UIManager - UIManager Widget

=head1 OBJECT HIERARCHY

=over 4

=item L<Gapp::Widget>

=item +-- L<Gapp::UIManager>

=back

=head1 PROVIDED ATTRIBUTES

=over 4

=item B<acton_args>

=over 4

=item isa: ArrayRef

=back

=item B<actions>

=over 4

=item isa: ArrayRef

=back

=item B<files>

=over 4

=item isa: ArrayRef

=back

=back

=head1 AUTHORS

Jeffrey Ray Hallock E<lt>jeffrey.hallock at gmail dot comE<gt>

=head1 COPYRIGHT & LICENSE

    Copyright (c) 2011 Jeffrey Ray Hallock.

    This program is free software; you can redistribute it and/or
    modify it under the same terms as Perl itself.

=cut
