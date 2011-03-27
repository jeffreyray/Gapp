package Gapp::ListStore;

use Moose;
use MooseX::SemiAffordanceAccessor;
use MooseX::Types::Moose qw( HashRef );

extends 'Gapp::Widget';


has '+class' => (
    default => 'Gtk2::ListStore',
);

has 'columns' => (
    is => 'rw',
    isa => 'ArrayRef',
    default => sub { [ ] },
);

has 'content' => (
    is => 'rw',
    isa => 'ArrayRef',
    default => sub { [ ] },
);

sub BUILDARGS {
    my $class = shift;
    my %args = @_ == 1 && is_HashRef( $_[0] ) ? %{$_[0]} : @_;
    
    if ( exists $args{columns} ) {
        $args{args} = [ @{ $args{columns} } ] if ! exists $args{args};
    }
    
    __PACKAGE__->SUPER::BUILDARGS( %args );
}

1;
