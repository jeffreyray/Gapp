package Gapp::Gtk2::FormFactory::Widget;

use strict;
use base qw( Gtk2::Ex::FormFactory::Widget );

sub object_to_widget {
    my $self = shift;
    $self->get_gtk_widget->set_value($self->get_object_value);
    1;
}

sub widget_to_object {
    my $self = shift;
    $self->set_object_value($self->get_gtk_widget->get_value);
    1;
}

sub empty_widget {
    my $self = shift;
    $self->get_gtk_widget->set_value(undef);
    1;
}

sub backup_widget_value {
    my $self = shift;
    $self->set_backup_widget_value ($self->get_gtk_widget->get_value);
    1;
}

sub restore_widget_value {
    my $self = shift;
    $self->get_gtk_widget->set_value($self->get_backup_widget_value);
    1;
}

sub get_widget_check_value {
    $_[0]->get_gtk_widget->get_value;
}

sub connect_changed_signal {
	my $self = shift;
	
	$self->get_gtk_widget->signal_connect (
	  'value-changed' => sub { $self->widget_value_changed },
	);
	
	1;
}


1;

__END__

=head1 NAME

Gi::Gtk2::FormFactory::Widget - Base class for Gi::Gtk2::FormFactory:: widgets

=head1 SYNOPSIS

  use base qw(Gi::Gtk2::FormFactory::Widget);

=head1 DESCRIPTION

This class is used as a base when implementing a Gi::Gtk2:: widget in the
FormFactory framework.

=head1 OBJECT HIERARCHY
  Gtk2::Ex::FormFactory::Widget


=head1 SEE ALSO
L<Gapp::Gtk2>
L<Gtk2::Ex::FormFactory>
L<Gtk2::Ex::FormFactory::Widget>

=head1 AUTHOR

Jeffrey Ray Hallock <jeffrey.hallock at gmail dot come>


