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

after _construct_gtk_widget => sub {
    my $self = shift;
   $self->gtk_widget->add_ui_from_file( $_ ) for @{ $self->files };
   $self->_apply_actions_to_gtk_widget;
};

sub _apply_actions_to_gtk_widget {
    my ( $self ) = @_;
    
    my $group = Gapp::ActionGroup->new( actions => $self->actions );
    $self->gtk_widget->insert_action_group( $group->gtk_widget, 0 );
}

1;
