package Gtk2::Ex::FormFactory::Frame;

use strict;

use base qw( Gtk2::Ex::FormFactory::Widget );

sub get_type { "frame" }

sub object_to_widget {
	my $self = shift;
	$self->get_gtk_widget->get_label->set_text($self->get_label);
	1;
}


1;

__END__

=head1 NAME

Gtk2::Ex::FormFactory::Frame - A Frame in a FormFactory framework

=head1 SYNOPSIS

  Gtk2::Ex::FormFactory::Frame->new (
    ...
    Gtk2::Ex::FormFactory::Widget attributes
  );

=head1 DESCRIPTION

This class implements an Frame in a Gtk2::Ex::FormFactory framework.


=head1 OBJECT HIERARCHY

  Gtk2::Ex::FormFactory::Intro

  Gtk2::Ex::FormFactory::Widget
  +--- Gtk2::Ex::FormFactory::Frame

  Gtk2::Ex::FormFactory::Layout
  Gtk2::Ex::FormFactory::Rules
  Gtk2::Ex::FormFactory::Context
  Gtk2::Ex::FormFactory::Proxy

=head1 ATTRIBUTES

This module has no additional attributes over those derived
from Gtk2::Ex::FormFactory::Widget. 

=head1 AUTHORS

 Jeffrey Ray <jeffrey at jeffrey ray dot info >

=head1 COPYRIGHT AND LICENSE

Copyright 2009 by Jeffrey Ray Hallock

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
