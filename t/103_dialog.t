#!/usr/bin/perl -w
use strict;
use warnings;

package Gapp::Layout::Subclass;

use Gapp::Layout;
extends 'Gapp::Layout::Default';

build 'Gapp::Dialog', sub {
    my ( $layout, $widget ) = @_;
    $layout->parent->build_widget( $widget ) if $layout->has_parent;
    $widget->gtk_widget->set_border_width( 6 );
    $widget->gtk_widget->vbox->set_spacing( 6 );
    $widget->gtk_widget->set_default_size( 300, 100 );
};

use Test::More qw( no_plan );

use Gtk2 '-init';
use_ok 'Gapp::Dialog';

use Gapp;
$Gapp::Layout = Gapp::Layout::Subclass->Layout;

my $w = Gapp::Dialog->new(
    title => 'Gapp',
    buttons => [ 'gtk-yes', 'gtk-no' ],
    content => [
        Gapp::Label->new( markup => '<b>Error</b>' ),
        Gapp::Label->new( text => 'Close this window?' ),
    ],
    #traits => [qw( )],
);
#ok $w, 'created gapp window';
#ok $w->gtk_widget, 'created gtk widget';
#
#$w->gtk_widget->show_all;
#$w->gtk_widget->run;
