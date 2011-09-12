package Gapp::Meta::Widget::Native::Trait::FormField;

use Moose::Role;
with 'Gapp::Meta::Widget::Native::Trait::FormElement';

# the field name to use when storing the value
has 'field' => (
    is => 'rw',
    isa => 'Maybe[Str]',
    default => undef,
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

# block the on_change handler
has 'block_on_change' => (
    is => 'rw',
    isa => 'Bool',
    default => 0,
);


sub _widget_value_changed {
    my ( $self ) = @_; # $self = the form field
    return if $self->is_updating;
    
    my $form = $self->form;
    
    if ( $form && $self->field ) {
        $self->widget_to_stash( $form->stash );
        
        if ( $self->field && $form->sync && $form->context ) {
            $form->context->modify( $self->field, $form->stash->fetch( $self->field ) )
        }
    }
    if ( ! $self->block_on_change && ! $self->is_updating ) {
        $self->on_change->( $self ) if $self->on_change;
    }
    
}

before _apply_signals => sub {
    my ( $self ) = @_;
    $self->_connect_changed_handler if $self->can('_connect_changed_handler');
};

package Gapp::Meta::Widget::Custom::Trait::FormField;
sub register_implementation { 'Gapp::Meta::Widget::Native::Trait::FormField' };


1;