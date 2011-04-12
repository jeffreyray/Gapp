#!/usr/bin/perl -w
use strict;
use warnings;

use Test::More qw( no_plan );

use Gtk2 '-init';
use_ok 'Gapp::ComboBox';

use Gapp;

{   # Basic combox box with stings
    my $w = Gapp::ComboBox->new(
        values => [ 'foo', 'bar', 'baz', ]
    );
    ok $w, 'created gapp widget';
    ok $w->gtk_widget, 'created gtk widget';
    
    my $model = $w->gtk_widget->get_model;
    my $iter = $model->get_iter_first;
    ok $model->get( $iter ), 'got foo';
    
    $iter = $model->iter_next( $iter );
    ok $model->get( $iter ), 'got bar';
    
    $iter = $model->iter_next( $iter );
    ok $model->get( $iter ), 'got baz';
}


{   # Basic combox box with sub as values
    my $w = Gapp::ComboBox->new(
        values => sub { 'foo', 'bar', 'baz' }
    );
    ok $w, 'created gapp widget';
    ok $w->gtk_widget, 'created gtk widget';
    
    my $model = $w->gtk_widget->get_model;
    my $iter = $model->get_iter_first;
    ok $model->get( $iter ), 'got foo';
    
    $iter = $model->iter_next( $iter );
    ok $model->get( $iter ), 'got bar';
    
    $iter = $model->iter_next( $iter );
    ok $model->get( $iter ), 'got baz';
    
    Gapp::Window->new( content => [ $w ] )->show_all;
}

{   # Basic combox box with sub as values
    my $w = Gapp::ComboBox->new(
        values => sub { 'foo', 'bar', 'baz' }
    );
    ok $w, 'created gapp widget';
    ok $w->gtk_widget, 'created gtk widget';
    
    my $model = $w->gtk_widget->get_model;
    my $iter = $model->get_iter_first;
    ok $model->get( $iter ), 'got foo';
    
    $iter = $model->iter_next( $iter );
    ok $model->get( $iter ), 'got bar';
    
    $iter = $model->iter_next( $iter );
    ok $model->get( $iter ), 'got baz';
    
    Gapp::Window->new( content => [ $w ] )->show_all;
}
