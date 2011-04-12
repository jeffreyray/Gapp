package Gapp::Meta::Widget::Native::Trait::FormElement;

use Moose::Role;

has 'form' => (
    is => 'ro',
    lazy_build => 1,
    weak_ref => 1,
);

sub _build_form {
    my ( $self ) = @_;
    
    my $node = $self;   
    while ( $node ) {
        return $node if $node->does('Gapp::Meta::Widget::Native::Trait::Form');
        return if ! $node->parent;
        $node = $node->parent;
    }
}

package Gapp::Meta::Widget::Custom::Trait::FormElement;
sub register_implementation { 'Gapp::Meta::Widget::Native::Trait::FormElement' };


1;