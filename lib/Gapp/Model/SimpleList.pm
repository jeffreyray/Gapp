package Gapp::Model::SimpleList;

use Glib qw(TRUE FALSE);
use Gtk2;
use Carp;
use Data::Dumper;
use strict;
use warnings;

use Glib::Object::Subclass
	Glib::Object::,
	interfaces => [ Gtk2::TreeModel:: ],
	;

sub INIT_INSTANCE {
	my $self = shift;
	$self->{n_columns} = 1;
	$self->{column_types} = [ 'Glib::Scalar' ];
	$self->{rows}     = [];
	$self->{stamp} = sprintf '%d', rand (1<<31);
}

sub FINALIZE_INSTANCE {
	my $self = shift;

	# free all records and free all memory used by the list
	# warning IMPLEMENT
	
}

sub GET_FLAGS { [qw/list-only/] }
sub GET_N_COLUMNS { shift->{n_columns}; }

sub GET_COLUMN_TYPE {
    my ($self, $index) = @_;
    return $self->{column_types}[$index];
}

sub GET_ITER {
	my ($self, $path) = @_;

	die "no path" unless $path;

	my @indices = $path->get_indices;
	my $depth   = $path->get_depth;

	# no children, this is a list
	die "depth != 1" unless $depth == 1;

	my $n = $indices[0];
	return undef if $n >= @{$self->{rows}} || $n < 0;

	my $record = $self->{rows}[$n];

	die "no record" unless $record;
	die "bad record" unless $record->{pos} == $n;

	return [ $self->{stamp}, $n, $record, undef ];
}


sub GET_PATH {
	my ($self, $iter) = @_;
	die "no iter" unless $iter;

	my $record = $iter->[2];

	my $path = Gtk2::TreePath->new;
	$path->append_index ($record->{pos});
	return $path;
}

sub GET_VALUE {
    my ($self, $iter, $column) = @_;

    die "bad iter" unless $iter;

    my $record = $iter->[2];

    return undef unless $record;

    die "bad iter" if $record->{pos} >= @{$self->{rows}};

    return $record->{value};
}

sub ITER_NEXT {
	my ($self, $iter) = @_;

	return undef unless $iter && $iter->[2];

	my $record = $iter->[2];

	# Is this the last record in the list?
	return undef if $record->{pos} >= @{ $self->{rows} };

	my $nextrecord = $self->{rows}[$record->{pos} + 1];

	return undef unless $nextrecord;
	die "invalid record" unless $nextrecord->{pos} == ($record->{pos} + 1);

	return [ $self->{stamp}, $nextrecord->{pos}, $nextrecord, undef ];
}

sub ITER_CHILDREN {
	my ($self, $parent) = @_;
	return undef if $parent; # this is a list, nodes have no children
	return undef unless @{ $self->{rows} }; 	# No rows => no first row
	return [ $self->{stamp}, 0, $self->{rows}[0] ]; 	# Set iter to first item in list
}


sub ITER_HAS_CHILD { FALSE }


sub ITER_N_CHILDREN {
	my ($self, $iter) = @_;
	# special case: if iter == NULL, return number of top-level rows
	return scalar @{$self->{rows}}	if ! $iter;

	return 0; # otherwise, this is easy again for a list
}


sub ITER_NTH_CHILD {
	my ($self, $parent, $n) = @_;

	# a list has only top-level rows
	return undef if $parent;

	# special case: if parent == NULL, set iter to n-th top-level row

	return undef if $n >= @{$self->{rows}};

	my $record = $self->{rows}[$n];

	die "no record" unless $record;
	die "bad record" unless $record->{pos} == $n;

	return [ $self->{stamp}, $n, $record ];
}


sub ITER_PARENT { FALSE }

sub append {
	my ( $self, $object ) = @_;
	
	my $record = { value => $object };
	
	push @{ $self->{rows} }, $record;
	$record->{pos} = @{$self->{rows}} - 1;
	
	my $path = Gtk2::TreePath->new;
	$path->append_index( $record->{pos} );
	
	my $iter = $self->get_iter( $path );
	$self->row_inserted( $path, $iter );
	return $self->get_iter( $path );
}


sub set {
    my ( $self, $treeiter, $value ) = @_;

	my $iter = $treeiter->to_arrayref($self->{stamp});
	
	my $record = $iter->[2];
	$record->{value} = $value;

	$self->row_changed ($self->get_path ($treeiter), $treeiter);
}





1;
