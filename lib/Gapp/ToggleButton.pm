package Gapp::ToggleButton;

use Moose;
use MooseX::SemiAffordanceAccessor;

extends 'Gapp::Button';
with 'Gapp::Meta::Widget::Native::Trait::FormField';

has '+class' => (
    default => 'Gtk2::ToggleButton',
);

has 'value' => (
    is => 'rw',
    isa => 'Str',
    default => '1',
);


sub BUILDARGS {
    my $class = shift;
    my %args = @_ == 1 && is_HashRef( $_[0] ) ? %{$_[0]} : @_;
    
    if ( exists $args{active} ) {
        $args{active} = [ $args{active} ];
    }
    
    __PACKAGE__->SUPER::BUILDARGS( %args );
}

sub get_field_value {
    my $self = shift;
    my $state = $self->gtk_widget->get_active;
    if ( $state ) {
        return $self->value;
    }
    else {
        return undef;
    }
}


sub set_field_value {
    my ( $self, $value ) = @_;
    if ( defined $value && $value eq $self->value ) {
        $self->gtk_widget->set_active( 1 )
    }
    else {
        $self->gtk_widget->set_active( 0 )
    }
}

sub widget_to_stash {
    my ( $self, $stash ) = @_;
    $stash->store( $self->field, $self->get_field_value );
}

sub stash_to_widget {
    my ( $self, $stash ) = @_;
    $self->set_field_value( $stash->fetch( $self->field ) );
}

1;
