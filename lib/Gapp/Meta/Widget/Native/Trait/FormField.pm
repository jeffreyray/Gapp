package Gapp::Meta::Widget::Native::Trait::FormField;

use Moose::Role;
with 'Gapp::Meta::Widget::Native::Trait::FormElement';

# the field name to use when storing the value
has 'field' => (
    is => 'rw',
    isa => 'Str',
    default => '',
);

# is true if the widget is currently being updated
# used to prevent recursive updates
has 'is_updating' => (
    is => 'rw',
    isa => 'Bool',
    default => 0,
);

# called after a fields value is changed
has 'on_change' => (
    is => 'rw',
    isa => 'CodeRef|Undef',
);


sub _widget_value_changed {
    my ( $self ) = @_; # $self = the form field
    return if $self->is_updating;
    
    my $form = $self->form;
    $self->widget_to_stash( $form->stash );
    $self->on_change->( $self ) if $self->on_change;
}

before _apply_signals => sub {
    my ( $self ) = @_;
    $self->_connect_changed_handler if $self->can('_connect_changed_handler');
};

package Gapp::Meta::Widget::Custom::Trait::FormField;
sub register_implementation { 'Gapp::Meta::Widget::Native::Trait::FormField' };


1;