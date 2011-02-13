package Gapp::Gtk2::FormFactory::OComboBox;
use base qw( Gapp::Gtk2::FormFactory::Widget );
sub get_type { 'o_combo_box' }


sub object_to_widget {
    my $self = shift;
    $self->get_gtk_widget->select( $self->get_object_value );
    1;
}

sub widget_to_object {
    my $self = shift;
    $self->set_object_value( $self->get_gtk_widget->get_selected );
    1;
}

sub empty_widget {
    my $self = shift;
    $self->get_gtk_widget->select( undef );
    1;
}

sub backup_widget_value {
    my $self = shift;
    $self->set_backup_widget_value ( $self->get_gtk_widget->get_selected );
    1;
}

sub restore_widget_value {
    my $self = shift;
    $self->get_gtk_widget->select( $self->get_backup_widget_value );
    1;
}

sub get_widget_check_value {
    $_[0]->get_gtk_widget->get_selected;
}

sub connect_changed_signal {
	my $self = shift;
	
	#$self->get_gtk_widget->signal_connect (
	#  'value-changed' => sub { $self->widget_value_changed },
	#);
	
	1;
}



package Gtk2::Ex::FormFactory::Layout;
use warnings;
use strict;

use Gapp::Gtk2::OComboBox;

sub build_o_combo_box {
    my $self = shift;
    my ( $ff ) = @_;
    
    my $gtk_widget = Gapp::Gtk2::OComboBox->new;
    $ff->set_gtk_widget( $gtk_widget );
    
    1;
}

1;

#form 'form' => (
#	content => sub {[
#		Entry
#	]}
#);
#
#Gapp::Form->new(
#	'content' => [
#		Gapp::Form::Entry->new( attr =>)
#	]
#);
#

__END__

=head1 NAME

Gapp::Gtk2::FormFactory::OComboBox - An OComboBox in a FormFactory framework

=head1 SYNOPSIS

  Gapp::Gtk2::FormFactory::OComboBox->new (
    ...
    Gtk2::Ex::FormFactory::Widget attributes
  );

=head1 DESCRIPTION

This class implements a Gapp::Gtk2::FormFactory::OComboBox in a
Gtk2::Ex::FormFactory framework. 

=head1 OBJECT HIERARCHY

  Gtk2::Ex::FormFactory::Widget
  +--- Gi::Gtk2::FormFactory::ObjectButton


=head1 ATTRIBUTES

This module has no additional attributes over those derived
from Gtk2::Ex::FormFactory::Widget. 

=head1 SEE ALSO

L<Gapp::Gtk2::OComboBox>

=head1 AUTHOR

Jeffrey Ray Hallock <jeffrey.ray at gmail dot com>
