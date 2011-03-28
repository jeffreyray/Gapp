package Gapp::Meta::Widget::Native::Trait::FormField;

use Moose::Role;

has 'form' => (
    is => 'ro',
    lazy_build => 1,
    weak_ref => 1,
);

has 'field' => (
    is => 'rw',
    isa => 'Str',
    default => '',
);

sub _build_form {
    my ( $self ) = @_;
    
    
    my $node = $self;
    print $self->find_ancestors, "\n";
    
    
    while ( $node ) {
        
        return $node if $node->does('Gapp::Meta::Widget::Native::Trait::Form');
        return if ! $node->parent;
        $node = $node->parent;
    }
}

package Gapp::Meta::Widget::Custom::Trait::FormField;
sub register_implementation { 'Gapp::Meta::Widget::Native::Trait::FormField' };


1;