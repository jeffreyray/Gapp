package Gapp::TableCell;

use Moose;
use MooseX::SemiAffordanceAccessor;
use MooseX::StrictConstructor;

has [qw( left right top bottom )] => (
    is => 'rw',
    isa => 'Int',
);

has [qw( hexpand vexpand )] => (
    is => 'rw',
    isa => 'ArrayRef',
);

has [qw( xalign yalign )] => (
    is => 'rw',
    isa => 'Num',
);

sub table_attach {
    my ( $self ) = @_;
    return $self->left, $self->right, $self->top, $self->bottom, $self->hexpand, $self->vexpand;
}

1;
