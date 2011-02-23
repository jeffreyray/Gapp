package Gapp::MenuToolButton;

use Moose;
use MooseX::SemiAffordanceAccessor;
extends 'Gapp::ToolButton';

has '+class' => (
    default => 'Gtk2::MenuToolButton',
);

has 'menu' => (
    is => 'rw',
    isa => 'Gapp::Menu',
);

after '_construct_gtk_widget' => sub {
    my ( $self ) = @_;
    $self->gtk_widget->set_menu( $self->menu->gtk_widget ) if $self->menu;
};

1;
