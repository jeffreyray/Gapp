package Gapp::Meta::Widget::Native::Role::FormElement;

use Moose::Role;
use MooseX::SemiAffordanceAccessor;


has 'form' => (
    is => 'ro',
    lazy_build => 1,
    weak_ref => 1,
    predicate => 'has_form',
    clearer => 'clear_form',
);

sub form {
    my ( $self ) = @_;
    
    print "\t-$self\n";
    
    my $node = $self;   
    while ( $node ) {
        return $node if $node->does('Gapp::Meta::Widget::Native::Trait::Form');
        return if ! $node->parent;
        $node = $node->parent;
    }
}

1;