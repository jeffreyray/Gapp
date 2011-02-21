#!/usr/bin/perl -w
use strict;
use warnings;


package Gapp::Layout::Subclass;

use Gapp::Layout;
extends 'Gapp::Layout::Default';

build 'Gapp::Window', sub {
    my ( $layout, $widget ) = @_;
    $layout->parent->build_widget( $widget );
};

add 'Gapp::Label', to 'Gapp::Dialog', sub {
    my ( $layout, $widget, $container ) = @_;
};


package main;
use Test::More qw( no_plan );

use Gapp::Layout::Default;

my $layout =  Gapp::Layout::Default->Layout;
ok ( $layout, 'created layout object' );
ok ( $layout->get_packer( 'Gapp::Widget', 'Gapp::Container' ), 'got packer' );