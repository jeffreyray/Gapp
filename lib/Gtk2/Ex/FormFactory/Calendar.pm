package Gtk2::Ex::FormFactory::Calendar;

use strict;

use base qw( Gtk2::Ex::FormFactory::Widget );

sub get_type { "calendar" }

sub object_to_widget {
	my $self = shift;
	
	my $o_value = $self->get_object_value;
	
	
	my ($y, $m, $d);
	if ($o_value) {
		($y, $m, $d) = split /-/, $o_value;
	}
	else {
		($d, $m, $y) = (localtime)[3,4,5];
		$y+=1900;
	}
	$m--;
	my $w_value = join '-', $y, $m, $d;
	$self->get_gtk_widget->select_month($m, $y);
	$self->get_gtk_widget->select_day($d);

	1;
}

sub widget_to_object {
	my $self = shift;
	my ($y, $m, $d) = $self->get_gtk_widget->get_date;
	$m++;
	my $o_value = join '-', $y, $m, $d;
	$self->set_object_value ($o_value);
	
	1;
}

sub empty_widget {
	my $self = shift;
	$self->get_gtk_widget->select_day(0);
	1;
}

sub backup_widget_value {
	my $self = shift;
	my ($y, $m, $d) = $self->get_gtk_widget->get_date;
	my $b_value = join '-', $y, $m, $d;
	$self->set_backup_widget_value ($b_value);
	
	1;
}

sub restore_widget_value {
	my $self = shift;

	my $b_value = $self->get_object_value;
	
	
	my ($y, $m, $d);
	if ($b_value) {
		($y, $m, $d) = split /-/, $b_value;
	}
	else {
		($d, $m, $y) = (localtime)[3,4,5];
		$y+=1900;
		$m--;
	}

	my $w_value = join '-', $y, $m, $d;
	$self->get_gtk_widget->select_month($m, $y);
	$self->get_gtk_widget->select_day($d);
	
	1;
}

sub get_widget_check_value {
	$_[0]->get_gtk_widget->get_date;
}

sub connect_changed_signal {
	my $self = shift;

	$self->get_gtk_widget->signal_connect (
	  'month-changed' => sub { $self->widget_value_changed },
	);
	$self->get_gtk_widget->signal_connect (
	  'day-selected' => sub { $self->widget_value_changed },
	);
	
	1;
}

1;

__END__

=head1 NAME

Gtk2::Ex::FormFactory::Calendar - A calendar in a FormFactory framework

=head1 SYNOPSIS

  Gtk2::Ex::FormFactory::Calendar->new (
    ...
    Gtk2::Ex::FormFactory::Widget attributes
  );

=head1 DESCRIPTION

This class implements an Calendar in a Gtk2::Ex::FormFactory framework.
The content of the Calendar is the value of the associated application
object attribute.

=head1 OBJECT HIERARCHY

  Gtk2::Ex::FormFactory::Intro

  Gtk2::Ex::FormFactory::Widget
  +--- Gtk2::Ex::FormFactory::Calendar

  Gtk2::Ex::FormFactory::Layout
  Gtk2::Ex::FormFactory::Rules
  Gtk2::Ex::FormFactory::Context
  Gtk2::Ex::FormFactory::Proxy

=head1 ATTRIBUTES

This module has no additional attributes over those derived
from Gtk2::Ex::FormFactory::Widget. 

=head1 AUTHORS

 Jeffrey Ray <jeffrey at jeffrey.ray dot net>
 Jörn Reder <joern at zyn dot de>

=head1 COPYRIGHT AND LICENSE

Copyright 2004-2010 by Jeffrey Ray Hallock, Jörn Reder.

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
