#!/usr/bin/perl -w
use strict;
use warnings;

use Gtk2 '-init';


package HelloWorld;

use Gapp::Moose::Gtk2;
use MooseX::Method::Signatures;

widget 'window' => (
    is => 'ro',
    traits => [ qw/GtkWindow DefaultWidget/ ],
    properties => {
        title => 'Gapp Application',
    },
    signal_connect => [
        ['delete-event' => sub { Gtk2->main_quit }],
    ],
    build => '_build_window',
);

widget 'label' => (
    is => 'ro',
    traits => [ 'GtkLabel' ],
    text => 'Hello World!',
    lazy => 1,
);

method _build_window ( $w ) {
    $w->add( $self->label );
}

package main;


my $gapp_object = HelloWorld->new;
$gapp_object->show_all;

Gtk2->main;
