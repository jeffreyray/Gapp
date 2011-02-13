package Gapp::Gtk2::OComboBox;
use strict;
use warnings;
use Carp qw(cluck carp);

use Glib qw(TRUE FALSE);
use Gtk2;

use Scalar::Util qw(refaddr blessed);

use Gapp::Gtk2::List::Simple;

# register as a glib class
use Glib::Object::Subclass
    Gtk2::ComboBox::,
;

sub INIT_INSTANCE {
    my $self = shift;   
    $self->set_model( Gapp::Gtk2::List::Simple->new );
}
    
sub get_equality_function {
    $_[0]->{equality_function} || \&_default_equality_function;
}

sub set_equality_function {
    $_[0]->{equality_function} = $_[1];
}

sub _check_equality {
    my $self = shift;
    my $function = $self->get_equality_function;
    return undef if ! defined $function;
    &$function( @_ );
}

sub _default_equality_function {
    my ($arg1, $arg2) = @_;
    return TRUE  if ! defined $arg1 && ! defined $arg2;
    return FALSE if ! defined $arg1 || ! defined $arg2;
    $_[0] == $_[1];
}

sub get_iter_from_object {
    my ( $self, $object ) = @_;
    cluck 'usage: $combo->get_iter_from_object($object)' and return unless @_ == 2;
    my $model  = $self->get_model;
    
    
    # throw exception if bad argument
    cluck 'usage: $combo->get_iter_from_object($object)' and return if ! blessed $object;
    
    # otherwise, try and find the object
    my $iter   = $model->get_iter_first;
    my $found;
    
    # find the object in the list
    while( $iter && ! $found ) {
        
        my $check_obj = $model->get( $iter, 0 );
        
        if ( $self->_check_equality( $object, $check_obj ) ) {
            $found = $iter;
        }
        
        $iter = $model->iter_next($iter);
    }
    
    # return the iter if one found
    return $found ? $found : undef;
}

sub get_selected {
    my $self = shift;
    my $iter = $self->get_active_iter;
    return undef if ! $iter;
    
    my $model  = $self->get_model;
    my $object = $model->get( $iter, 0 );
    
    return $object ? $object : undef;
}



sub select {
    my ( $self, $object ) = @_;
    
    # throw exception
    cluck 'Usage: Gapp::Gtk1::OComboBox::select($combo, $object | undef)'
        and return unless @_ == 2;
        
    
    # if passed in undef, select no object
    if ( ! defined $object ) {
        $self->set_active( 0 );
    }
    elsif ( blessed $object ) {
        my $iter = $self->get_iter_from_object($object);
        
        if ($iter) {
            $self->set_active_iter($iter);
        }
        else {
            carp "could not find object $object in ComboBox";
        }
        
    }
    else {
        cluck 'usage: $combo->set_value($object | undef)' and return;
    }
}


1;

__END__

=head1 NAME

Gapp::Gtk2::OComboBox - A ComboBox to use with objects

=head1 SYNOPSIS

  use Gapp::Gtk2::OComboBox;

  $combo = Gapp::Gtk2::OComboBox->new;

  $model = $combo->get_model;
  
  $model->set($model->append, 0 => $object);

  $combo->set_value($object);

  $object = $combo->get_value;
  

=head1 OBJECT HEIRARCHY

  Glib::Object
    +----Gtk2::ComboBox
      +----Gapp::Gtk2::OComboBox

=head1 DESCRIPTION

Gapp::Gtk2::OComboBox allows you to display and select objects.

=head1 METHODS

=head2 $combo->get_iter_from_object( Object )

Returns an $iter pointing to the location of the object in the model. Returns
undef if the object is not in the model.

=head1 $combo->get_equality_function

Returns the function used to determine if

=head2 $combo->get_selected

Returns the currently selected object.

=head2 $combo->select( Object | Undef )

Sets the currently selectd objected. You may pass undef for no selection.

=head2 $combo->select_or_add( Object )

The object is selected, being added to the model first if necessary.



=head1 AUTHOR

Jeffrey Ray Hallock, <jhallock.hallock at gmail dot com>




1;
