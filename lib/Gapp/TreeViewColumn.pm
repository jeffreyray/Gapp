package Gapp::TreeViewColumn;

use Moose;
extends 'Gapp::Widget';

use Gapp::CellRenderer;
use Gapp::Util;
use Gapp::Types qw( GappCellRenderer GappTreeViewColumn );

use Moose::Util;
use MooseX::Types::Moose qw( ArrayRef HashRef );

has '+class' => (
    default => 'Gtk2::TreeViewColumn',
);

has 'name' => (
    is => 'rw',
    isa => 'Str',
    default => '',
);

has 'renderer' => (
    is => 'rw',
    isa => GappCellRenderer,
    default => sub { Gapp::CellRenderer->new( class => 'Gtk2::CellRendererText', property => 'markup' ) },
    coerce => 1,
);

has 'data_func' => (
    is => 'rw',
    isa => 'Str|CodeRef|Undef',
);

has 'data_column' => (
    is => 'rw',
    isa => 'Int|Undef',
    default => undef,
);

sub BUILDARGS {
    my $class = shift;
    my %args = @_ == 1 && is_HashRef( $_[0] ) ? %{$_[0]} : @_;
    
    if ( exists $args{title} ) {
        $args{properties}{title} = $args{title};
        delete $args{title};
    }
    __PACKAGE__->SUPER::BUILDARGS( %args );
}



1;
