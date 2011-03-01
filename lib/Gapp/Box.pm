package Gapp::Box;

use Moose;
use MooseX::SemiAffordanceAccessor;

extends 'Gapp::Container';

has '+class' => (
    default => 'Gtk2::Box',
);

sub BUILDARGS {
    my $class = shift;
    my %args = @_ == 1 && is_HashRef( $_[0] ) ? %{$_[0]} : @_;
    
    if ( exists $args{spacing} ) {
        $args{properties}{spacing} = $args{spacing};
        delete $args{spacing};
    }
    if ( exists $args{homogeneous} ) {
        $args{properties}{homogeneous} = $args{homogeneous};
        delete $args{homogeneous};
    }
    
    __PACKAGE__->SUPER::BUILDARGS( %args );
}

1;
