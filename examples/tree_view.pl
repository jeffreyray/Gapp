#!/usr/bin/perl -w
use strict;
use warnings;

use Gtk2 '-init';
use lib qw( lib examples/lib );

package MyApplicationObject;

use Gapp;
use MooseX::Method::Signatures;


widget 'list_store' => (
    is => 'rw',
    traits => [qw( GtkListStore )],
    columns => [qw( Glib::String Glib::String Glib::String Glib::String )],
    build => sub {
        my ( $self, $w ) = @_;
        my $iter = $w->append;
        $w->set( $iter, 0 => 0, 1 => 60489, 2 => 'Critical', 3 => 'Bug description' );
    }
);

widget 'tree_view' => (
    is => 'ro',
    traits => [ 'GtkTreeView' ],
    columns => [
        [ 'Fixed?'     , 0 ],
        [ 'Bug Number' , 1 ],
        [ 'Severity'   , 2 ],
        [ 'Description', 3 ],
    ],
    build => sub {
        my ( $self, $w ) = @_;
        $w->set_model( $self->list_store );
    },
    lazy => 1,
);

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
        $vbox->pack_start( $self->tree_view, 1, 1, 0 );
        $w->add( $vbox );
    },
);







package main;

my $gapp_object = MyApplicationObject->new;
$gapp_object->window->show_all;

Gtk2->main;
