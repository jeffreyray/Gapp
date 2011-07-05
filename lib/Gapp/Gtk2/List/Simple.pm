package Gapp::Gtk2::List::Simple;

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
	$self->{rows} = undef;
	$self->{stamp} = undef;
	$self->{column_types} = undef;
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

sub clear {
    my ( $self ) = @_;
    
    while ( @{$self->{rows}} ) {
	my $record = pop @{ $self->{rows} };
	
	my $path = Gtk2::TreePath->new;
	$path->append_index( $record->{pos} );
	
	$self->row_deleted ( $path );
    }

}




1;



__END__

=pod

=head1 NAME

Gapp::Gtk2::List::Simple - A simple list that can hold arbitrary values

=head1 SYNOPSIS

  use Gtk2 '-init';

  use Gapp::Gtk2;

  $list = Gapp::Gtk2::List::Simple->new;

  $iter = $list->append( $value );

  $list->set( $iter, $new_value );
  
   
=head1 DESCRIPTION

<Gapp::Gtk2::List::Simple> is a very simpleL<Gtk2::TreeModel|http://library.gnome.org/devel/gtk/stable/GtkTreeModel.html>
that is implmented in perl. It has only column with no restrictions on the data
type it can hold. Nodes can not have children.

=head1 OBJECT HEIRARCHY

=over4

=item  L<Glib::Object|http://gtk2-perl.sourceforge.net/doc/pod/Glib/Object.html>

=item  +--L<Gapp::Gtk2::List::Simple>

=back 
  
=head2 Implemented Interfaces

=over 4

=item L<Gtk2::TreeModel|http://gtk2-perl.sourceforge.net/doc/pod/Gtk2/TreeModel.html>

=back

=head1 PROVIDED METHODS

=over 4

=item B<append ( $value )>

Adds the value to the list, returns an C<$iter> to reference the position.

=item B<set( $iter, $value )>

Sets the value at the position referenced by the C<$iter>.

=back

=head1 AUTHOR

Jeffrey Ray Hallock E<lt>jeffrey.hallock at gmail dot comE<gt>

=head1 COPYRIGHT

    Copyright (c) 2011 Jeffrey Ray Hallock.
    This program is free software; you can redistribute it and/or
    modify it under the same terms as Perl itself.

=cut

