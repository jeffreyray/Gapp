package Gapp::Window;

use Moose;
use MooseX::SemiAffordanceAccessor;
use MooseX::Types::Moose qw( HashRef );

extends 'Gapp::Container';

has '+class' => (
    default => 'Gtk2::Window',
);

sub BUILDARGS {
    my $class = shift;
    my %args = @_ == 1 && is_HashRef( $_[0] ) ? %{$_[0]} : @_;
    
    if ( exists $args{title} ) {
        $args{properties}{title} = $args{title};
        delete $args{title};
    }
    if ( exists $args{default_size} ) {
        $args{properties}{'default-width'} = $args{default_size}[0];
        $args{properties}{'default-height'} = $args{default_size}[1];
        delete $args{default_size};
    }
    
    __PACKAGE__->SUPER::BUILDARGS( %args );
}

1;
