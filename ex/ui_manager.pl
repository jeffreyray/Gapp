#!/usr/bin/perl -w
use strict;
use warnings;

package MyApplicationObject;
use Gapp::Moose;
use Gapp::Actions -declare => [qw( New Edit Delete )];

action New => (
    label => 'New',
    tooltip => 'New',
    icon => 'gtk-new',
    code => sub { print 'action: ' . $_[0]->name, "\n" },
);

action Edit => (
    label => 'Edit',
    tooltip => 'Edit',
    icon => 'gtk-edit',
    code => sub { print 'action: ' . $_[0]->name, "\n"  },
);

action Delete => (
    label => 'Delete',
    tooltip => 'Delete',
    icon => 'gtk-delete',
    code => sub { print 'action: ' . $_[0]->name, "\n"  },
);

widget 'window' => (
    is => 'ro',
    traits => [ 'GtkWindow' ],
    properties => {
        title => 'Gapp Application',
    },
    signal_connect => [
        ['delete-event' => sub { Gtk2->main_quit }],
    ],
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
    traits => [ qw( GappToolbar FromUIManager )],
    construct => sub {[
        ui => $_[0]->ui_manager,
        ui_widget => $_[0]->ui_manager->( 'Toolbar' ),
    ]},
    lazy => 1,
);

widget 'ui_manager' => (
    is => 'rw',
    files => [ 'examples/basic.ui' ],
    traits => [ qw/GtkUIManager/ ],
    actions => [ __PACKAGE__ ],
    lazy => 1,
);


package main;

use Gtk2 '-init';
my $gapp_object = MyApplicationObject->new;
$gapp_object->window->show_all;

Gtk2->main;
