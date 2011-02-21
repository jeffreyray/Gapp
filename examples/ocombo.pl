#!/usr/bin/perl -w
use strict;
use warnings;

use Gtk2 '-init';

package My::God;
use Moose;

has 'name' => ( is => 'rw' );

package My::Application;
use Gapp::Moose::Gtk2;

widget 'window' => (
    is => 'ro',
    traits => [ qw/GtkWindow DefaultWidget/ ],
    properties => {
        title => 'Gapp Application',
    },
    signal_connect => [
        'delete-event' => sub { Gtk2->main_quit },
    ],
    build => sub {
        my ( $self, $w ) = @_;
        $w->add( $self->combo );
    }
);

widget 'combo' => (
    is => 'ro',
    class => 'Gapp::Gtk2::OComboBox',
    lazy => 1,
    build => sub {
        my ( $self, $w ) = @_;
        
        my $render;
        $render = Gtk2::CellRendererText->new;
        $render->set( xalign => 0 );
        $render->set_fixed_size( 75, -1 );
        $w->pack_start( $render, 1 );
        $w->set_cell_data_func( $render, sub {
            my ($layout, $render, $model, $iter) = @_;
            my $object = $model->get($iter, 0);
            my $text   = $object ? $object->name : '';
            $render->set_property( text => $text );
        } );
        
        $w->get_model->append( $_ )
            for map { My::God->new( name => $_ ) }
            ( qw/Zues Ares Hermes Aphrodite Athena Hades Dionyssus/ );
    }
);


package main;


my $gapp_object = My::Application->new;
$gapp_object->show_all;

Gtk2->main;
