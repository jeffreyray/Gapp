package Gapp::Entry;

use Moose;
use MooseX::SemiAffordanceAccessor;

extends 'Gapp::Widget';

has '+class' => (
    default => 'Gtk2::Entry',
);

has 'text' => (
    is => 'rw',
    isa => 'Str|Undef',
);


sub BUILDARGS {
    my $class = shift;
    my %args = @_ == 1 && is_HashRef( $_[0] ) ? %{$_[0]} : @_;
    
    if ( exists $args{text} ) {
        $args{args} = [ $args{text} ];
    }
    
    __PACKAGE__->SUPER::BUILDARGS( %args );
}

1;
