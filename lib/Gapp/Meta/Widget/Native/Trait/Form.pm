package Gapp::Meta::Widget::Native::Trait::Form;

use Moose::Role;
use Gapp::Types qw( FormField );

has 'context' => (
    is => 'rw',
    isa => 'Gapp::Form::Context',
);

# update the user variables
sub apply {
    my ( $self ) = ( @_ );
    
    my $cx = $self->context;
    
}

# update the values in the form
sub update {
     my ( $self ) = ( @_ );
    
    my $cx = $self->context;
    
    for my $w ( $self->find_fields ) {
        $cx->update_widget( $w );
    }
    
}

sub find_fields {
     my ( $self ) = ( @ _ );
    
    my @fields;
    for my $w ( $self->find_descendants ) {
        push @fields, $w if is_FormField( $w );
    }
    
    return @fields;
}


package Gapp::Meta::Widget::Custom::Trait::Form;
sub register_implementation { 'Gapp::Meta::Widget::Native::Trait::Form' };


1;