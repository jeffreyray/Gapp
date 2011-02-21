package Gtk2::Ex::FormFactory::TextView;

use strict;

use base qw( Gtk2::Ex::FormFactory::Widget );

sub get_type { "text_view" }

sub new {
	my $class = shift;
	my %par = @_;
	my ($scrollbars, $properties) = @par{'scrollbars','properties'};
	
	my $self = $class->SUPER::new(@_);
	
	$scrollbars ||= [ "automatic", "automatic" ];

	if ( not $properties or not exists $properties->{wrap_mode} ) {
		$properties->{wrap_mode} = "word-char";
	}

	$self->set_scrollbars ($scrollbars);
	$self->set_properties ($properties);
	
	return $self;
}

sub object_to_widget {
	my $self = shift;

	$self->get_gtk_widget->get_buffer->set_text($self->get_object_value);

	1;
}

sub widget_to_object {
	my $self = shift;
	
	my $buffer = $self->get_gtk_widget->get_buffer;
	
	$self->set_object_value (
		$buffer->get_text(
			$buffer->get_start_iter,
			$buffer->get_end_iter,
			1,
		)
	);
	
	1;
}

sub empty_widget {
	my $self = shift;
	
	$self->get_gtk_widget->get_buffer->set_text("");
	
	1;
}

sub backup_widget_value {
	my $self = shift;
	
	my $buffer = $self->get_gtk_widget->get_buffer;
	
	$self->set_backup_widget_value (
		$buffer->get_text(
			$buffer->get_start_iter,
			$buffer->get_end_iter,
			1,
		)
	);
	
	1;
}

sub restore_widget_value {
	my $self = shift;
	
	$self->get_gtk_widget
	     ->get_buffer
	     ->set_text($self->get_backup_widget_value);
	
	1;
}

sub get_widget_check_value {
	$_[0]->get_gtk_widget->get_buffer->get_text;
}

sub connect_changed_signal {
	my $self = shift;

	$self->get_gtk_widget->get_buffer->signal_connect (
	  changed => sub { $self->widget_value_changed },
	);
	
	1;
}

1;

__END__

=head1 NAME

Gtk2::Ex::FormFactory::TextView - A TextView in a FormFactory framework

=head1 SYNOPSIS

  Gtk2::Ex::FormFactory::TextView->new (
    ...
    Gtk2::Ex::FormFactory::Widget attributes
  );

=head1 DESCRIPTION

This class implements a TextView in a Gtk2::Ex::FormFactory framework.
The content of the TextView is the value of the associated application
object attribute.

By default the TextView gets automatic horizontal and vertical scrollbars
and word wrapping enabled, unless you specify your own values for these
settings.

=head1 OBJECT HIERARCHY

  Gtk2::Ex::FormFactory::Intro

  Gtk2::Ex::FormFactory::Widget
  +--- Gtk2::Ex::FormFactory::TextView

  Gtk2::Ex::FormFactory::Layout
  Gtk2::Ex::FormFactory::Rules
  Gtk2::Ex::FormFactory::Context
  Gtk2::Ex::FormFactory::Proxy

=head1 ATTRIBUTES

This module has no additional attributes over those derived
from Gtk2::Ex::FormFactory::Widget. 

=head1 AUTHORS

 J�rn Reder <joern at zyn dot de>

=head1 COPYRIGHT AND LICENSE

Copyright 2004-2006 by J�rn Reder.

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
