package Gapp::ToggleButton;

use Moose;
use MooseX::SemiAffordanceAccessor;

extends 'Gapp::Button';
with 'Gapp::Meta::Widget::Native::Trait::FormField';

has '+class' => (
    default => 'Gtk2::ToggleButton',
);

sub BUILDARGS {
    my $class = shift;
    my %args = @_ == 1 && is_HashRef( $_[0] ) ? %{$_[0]} : @_;
    
    if ( exists $args{active} ) {
        $args{active} = [ $args{active} ];
    }
    
    __PACKAGE__->SUPER::BUILDARGS( %args );
}

1;
