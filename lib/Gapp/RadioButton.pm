package Gapp::RadioButton;

use Moose;
use MooseX::SemiAffordanceAccessor;

extends 'Gapp::CheckButton';

has '+class' => (
    default => 'Gtk2::RadioButton',
);

# create and set the actual gtk_widget
sub _construct_gtk_widget {
    my ( $self ) = @_;
    
    my $gtk_class = $self->class;
    my $gtk_constructor = $self->constructor;
    
    # determine the radio group
    my $group = $self->field && $self->parent ?
    $self->parent->{_rdo_groups}{ $self->field } :
    undef;
    
    # use any build-arguments if they exist
    my $w = $gtk_class->$gtk_constructor( $group, $self->args ? @{$self->args} : ( ) );
    $self->set_gtk_widget( $w );
    
    # save the radio group in the parent
    if ( $self->parent ) {
        $self->parent->{_rdo_groups}{ $self->field } ||= $w->get_group;
    }
    
    
    return $w;
}

sub get_field_value {
    my $self = shift;
    my $state = $self->gtk_widget->get_active;
    if ( $state ) {
        return $self->value;
    }
}

sub widget_to_stash {
    my ( $self, $stash ) = @_;
    my $state = $self->gtk_widget->get_active;
    if ( $state ) {
        $stash->store( $self->field, $self->get_field_value );
    }
}

sub stash_to_widget {
    my ( $self, $stash ) = @_;
    $self->set_field_value( $stash->fetch( $self->field ) );
}

1;
