package Gapp::Entry;

use Moose;
use MooseX::SemiAffordanceAccessor;

extends 'Gapp::Widget';
with 'Gapp::Meta::Widget::Native::Trait::FormField';

has '+class' => (
    default => 'Gtk2::Entry',
);

sub BUILDARGS {
    my $class = shift;
    my %args = @_ == 1 && is_HashRef( $_[0] ) ? %{$_[0]} : @_;
    
    if ( exists $args{text} ) {
        $args{properties}{text} = [ $args{text} ];
        delete $args{text};
    }
    
    __PACKAGE__->SUPER::BUILDARGS( %args );
}

1;
