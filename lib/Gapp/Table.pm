package Gapp::Table;


use Moose;
extends 'Gapp::Container';

use Gapp::TableMap;
use Gapp::Types qw( GappTableMap );

has '+class' => (
    default => 'Gtk2::Table',
);

has 'map' => (
    is => 'rw',
    isa => GappTableMap,
    default => '',
	coerce => 1,
);

has '_active_cell' => (
	is => 'rw',
	isa => 'Maybe[Int]',
);

sub current_cell {
	my ( $self ) = @_;
	$self->_active_cell ? $self->map->cells->[ $self->_active_cell ] : undef;
}

sub next_cell {
	my ( $self ) = @_;
	
	my $x = defined $self->_active_cell ? $self->_active_cell + 1 : 0;
	my $cell = $self->map->cells->[$x];
	$self->_set_active_cell( $cell ? $x : undef );
	return $cell;
}


before _construct_gtk_widget => sub {
	my $self = shift;
	return $self->set_args( [ $self->map->row_count, $self->map->col_count, 0 ] );
};




1;
