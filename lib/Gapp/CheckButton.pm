package Gapp::CheckButton;

use Moose;
use MooseX::SemiAffordanceAccessor;

extends 'Gapp::ToggleButton';

has '+class' => (
    default => 'Gtk2::CheckButton',
);

sub get_field_value {
    my $self = shift;
    my $state = $self->gtk_widget->get_active;
    if ( $state ) {
        return $self->value;
    }
}

1;
