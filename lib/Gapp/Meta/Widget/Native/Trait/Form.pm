package Gapp::Meta::Widget::Native::Trait::Form;

use Moose::Role;
use Gapp::Form::Stash;
use Gapp::Types qw( FormContext FormField FormStash );


has 'context' => (
    is => 'rw',
    isa => FormContext,
);

has 'stash' => (
    is => 'rw',
    isa => FormStash,
    default => sub { Gapp::Form::Stash->new },
);

# update the user variables
sub apply {
    my ( $self ) = ( @_ );
    
    my $cx = $self->context;
    
}

# update the values in the form
sub update {
    my ( $self ) = ( @_ );
    $self->_update_fields;
}

sub find_fields {
     my ( $self ) = ( @ _ );
    
    my @fields;
    for my $w ( $self->find_descendants ) {
        push @fields, $w if is_FormField( $w );
    }
    
    return @fields;
}

sub _update_stash {
    my ( $self ) = @_;
    
    my $stash = $self->stash;
    
    for my $w ( $self->find_fields ) {
        $w->widget_to_stash( $stash );
    }
}

sub _update_fields {
    my ( $self ) = @_;
    
    for my $w ( $self->find_fields ) {
        $w->stash_to_widget( $self->stash );
    }
}


package Gapp::Meta::Widget::Custom::Trait::Form;
sub register_implementation { 'Gapp::Meta::Widget::Native::Trait::Form' };


1;