package Gapp::Button;

use Moose;
use MooseX::SemiAffordanceAccessor;

extends 'Gapp::Widget';

has '+class' => (
    default => 'Gtk2::Button',
);

has 'label' => (
    is => 'rw',
    isa => 'Str|Undef',
);



sub BUILDARGS {
    my $class = shift;
    my %args = @_ == 1 && is_HashRef( $_[0] ) ? %{$_[0]} : @_;
    
    if ( exists $args{label} && ! $args{args} ) {
        $args{args} = [ $args{label} ];
        $args{constructor} = 'new_with_label';
    }
    
    __PACKAGE__->SUPER::BUILDARGS( %args );
}

1;
