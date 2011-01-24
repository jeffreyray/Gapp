#!/usr/bin/perl -w
use strict;
use warnings;

use Gtk2 '-init';


package MyApplicationObject;

use Gapp;
use MooseX::Method::Signatures;

widget 'window' => (
    is => 'ro',
    traits => [ 'GtkWindow' ],
    properties => {
        title => 'Gapp Application',
    },
    signal_connect => {
        'delete-event' => sub { Gtk2->main_quit },
    },
    build => sub {
        my ( $self, $w ) = @_;
        my $vbox = Gtk2::VBox->new;
        $vbox->pack_start( $self->toolbar, 0, 0, 0 );
        $vbox->pack_start( $self->text_view, 1, 1, 0 );
        $w->add( $vbox );
    },
);

widget 'text_view' => (
    is => 'ro',
    traits => [ 'GtkTextView' ],
    lazy => 1,
);

widget 'toolbar' => (
    is => 'ro',
    traits => [ 'GtkToolbar' ],
    default => sub { $_[0]->ui_manager->get_widget('/Toolbar') },
    lazy => 1,
);

widget 'ui_manager' => (
    is => 'rw',
    files => [ 't/001_gapp/basic.ui' ],
    traits => [ qw/GtkUIManager/ ],
    actions => [
        [new      => 'New'    , 'New'    , 'gtk-new'     ],
        [edit     => 'Edit'   , 'Edit'   , 'gtk-edit'    ],
        [delete   => 'Delete' , 'Delete' , 'gtk-delete'  ],
    ],
    lazy => 1,
);


widget 'status_icon' => (
    is => 'rw',
    traits => [qw( GtkStatusIcon )],
    icon => 'gtk-info',
    tooltip => 'Gapp Application',
    build => sub {
        $_[1]->set_visible( 1 );
    }
);



package main;

my $gapp_object = MyApplicationObject->new;
$gapp_object->window->show_all;

Gtk2->main;
