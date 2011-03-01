package Gapp::Meta::Widget::Native::Trait::Form;

use Moose::Role;


has 'context' => (
    is => 'rw',
    isa => 'Gapp::Form::Context',
);

# update the user variables
sub apply {
    my $self = ( @_ );
    
    my $cx = $self->context;
    
}

# update the values in the form
sub update {
    my $self = ( @_ );
    
    my $cx = $self->context;
    
    for my $c ( $self->find_descendants ) {
        next if ! $c->does( 'FormField' );
    }
    
}


package Gapp::Meta::Widget::Custom::Trait::Form;
sub register_implementation { 'Gapp::Meta::Widget::Native::Trait::Form' };


1;