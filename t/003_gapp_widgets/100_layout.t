#!/usr/bin/perl -w
use strict;
use warnings;

package My::Layout;
use Gapp::Layout;


add 'Gapp::Widget', to 'Gapp::Container', sub {
    my ( $container, $child ) = @_;
    $container->gtk_widget->add( $child->gtk_widget );
};

add 'Gapp::Label', to 'Gapp::Window', sub {
    my ( $container, $child ) = @_;
    $container->gtk_widget->add( $child->gtk_widget );
};



package main;
use Test::More qw( no_plan );

my $layout =  My::Layout->Layout;
ok ( $layout, 'created layout object' );
ok ( $layout->has_packer( 'Gapp::Widget', 'Gapp::Container' ), 'has packer' );
ok ( $layout->get_packer( 'Gapp::Widget', 'Gapp::Container' ), 'got packer' );