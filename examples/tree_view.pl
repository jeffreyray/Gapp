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
        [ 'fixed'      , 'Fixed?'     , 'toggle', 0, undef, { build_renderer => \&_build_toggle } ],
        [ 'bug_number' , 'Bug Number' , 'text', 1, undef],
        [ 'severity'   , 'Severity'   , 'text', 2, undef],
        [ 'description', 'Description', 'text', 3, undef],
    ],
    build => sub {
        my ( $self, $w ) = @_;
        $w->set_model( $self->list_store );
        
        $w->{renderer}[0]->signal_connect(
            
        );
        
        
        
        $w->{column}{fixed}->signal_connect
    },
    lazy => 1,
);

sub _build_toggle {
    my $self = ( @_ );
    
    my $cell = Gtk2::CellRendererToggle->new;
    $cell->signal_connect( toggled =>  sub {
        
        my ( $cell, $path, $model ) = @_;
        $path = Gtk2::TreePath->new( $path );
        
        my $iter = $model->get_iter( $path );
        
        my ( $fixed ) = $model->get( $iter, 0 );
        
        $fixed ^= 1;
        
        $model->set( $iter, 0, $fixed );
        
    }, $self->tree_view->get_model);
    
    return $cell;
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
