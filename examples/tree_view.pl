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
    columns => [qw( Glib::Boolean Glib::String Glib::String Glib::String )],
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
        [ 'fixed'      , 'Fixed?'     , 'toggle', 0, undef, ],
        [ 'bug_number' , 'Bug Number' , 'text', 1, undef],
        [ 'severity'   , 'Severity'   , 'text', 2, undef],
        [ 'description', 'Description', 'text', 3, undef],
    ],
    build => sub {
        my ( $self, $w ) = @_;
        $w->set_model( $self->list_store );
        
        # this is kind of hackish, need a better way to implement
        
        $w->{columns}{fixed}{renderer}->signal_connect(
            toggled =>  \&_do_toggled,  [$self->list_store, 0]
        );
        
        
    },
    #lazy => 1,
);

sub _do_toggled {   
    my ( $cell, $path_str, $args ) = @_;
    my ( $model, $col ) = $args ? @$args : ();
    my $path = Gtk2::TreePath->new( $path_str );
    my $iter = $model->get_iter( $path );
    
    my ( $value ) = $model->get( $iter, $col );
    $value ^= 1;
    
    $model->set( $iter, $col, $value );
    
}


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
