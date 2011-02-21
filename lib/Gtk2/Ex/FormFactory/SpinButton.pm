package Gtk2::Ex::FormFactory::SpinButton;

use strict;

use base qw( Gtk2::Ex::FormFactory::Widget );

sub get_type { "spin_button" }

sub set_range { $_[0]->{range} = $_[1]    }
sub get_range { $_[0]->{range} || [0, 99, 1] }
sub set_digits { $_[0]->{digits} = $_[1]    }
sub get_digits { $_[0]->{digits} || 0 }


sub object_to_widget {
	my $self = shift;
	$self->get_gtk_widget->set_value($self->get_object_value);
	1;
}

sub widget_to_object {
	my $self = shift;
	$self->set_object_value ($self->get_gtk_widget->get_value);
	1;
}

sub empty_widget {
	my $self = shift;
	$self->get_gtk_widget->set_text("");
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
	  changed => sub { $self->widget_value_changed },
	);
	
	1;
}

1;

__END__

=head1 NAME

Gtk2::Ex::FormFactory::SpinButton - An SpinButton in a FormFactory framework

=head1 SYNOPSIS

  Gtk2::Ex::FormFactory::FormFactory->new (
    ...
    Gtk2::Ex::FormFactory::Widget attributes
  );

=head1 DESCRIPTION

This class implements an SpinButton in a Gtk2::Ex::FormFactory framework.
The content of the Entry is the value of the associated application
object attribute.

=head1 OBJECT HIERARCHY

  Gtk2::Ex::FormFactory::Intro

  Gtk2::Ex::FormFactory::Widget
  +--- Gtk2::Ex::FormFactory::SpinButton

  Gtk2::Ex::FormFactory::Layout
  Gtk2::Ex::FormFactory::Rules
  Gtk2::Ex::FormFactory::Context
  Gtk2::Ex::FormFactory::Proxy

=head1 ATTRIBUTES

This module has no additional attributes over those derived
from Gtk2::Ex::FormFactory::Widget. 

=head1 AUTHORS

 Jeffrey Ray Hallock <jeffrey at jeffrey.ray dot info>

=head1 COPYRIGHT AND LICENSE

Copyright 2010-2006 by Jeffrey Ray Hallock

This library is free software; you can redistribute it and/or modify
it under the terms of the GNU Library General Public License as
published by the Free Software Foundation; either version 2.1 of the
License, or (at your option) any later version.

This library is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Library General Public License for more details.

You should have received a copy of the GNU Library General Public
License along with this library; if not, write to the Free Software
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307
USA.

=cut
