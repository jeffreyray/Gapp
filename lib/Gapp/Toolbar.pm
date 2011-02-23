package Gapp::Toolbar;

use Moose;
use MooseX::SemiAffordanceAccessor;
extends 'Gapp::Container';

has '+class' => (
    default => 'Gtk2::Toolbar',
);

has 'icon_size' => (
    is => 'rw',
    isa => 'Str',
);

sub BUILDARGS {
    my $class = shift;
    my %args = @_ == 1 && is_HashRef( $_[0] ) ? %{$_[0]} : @_;
    
    if ( exists $args{style} ) {
        $args{properties}{'toolbar-style'} = $args{style};
        delete $args{style};
    }
    
    __PACKAGE__->SUPER::BUILDARGS( %args );
}

1;
