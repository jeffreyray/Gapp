#!/usr/bin/perl -w
use strict;
use warnings;

use lib qw(../lib);

package My::Object;
use Moose;

has 'number' => (is => 'rw');
has 'name'   => (is => 'rw');

package main;
use Gtk2 '-init';
use Glib qw(TRUE FALSE);

use Test::More 'no_plan';
use Scalar::Util qw(refaddr);

use Gapp::Gtk2::OComboBox;

&do_tests_one;

sub do_tests_one {
    my $widget = Gapp::Gtk2::OComboBox->new;
    my $model  = $widget->get_model;
    $model->append( undef );

    
    my @objects;
    for (0..9) {
        my $object = My::Object->new(number => sprintf("%04d", $_), name => "Test Object $_");
        my $iter = $model->append( $object );
        push @objects, $object;
    }
    
    my $iter = $model->get_iter_first;
       $iter = $model->iter_next($iter);
    for (0..9) {
        is(refaddr $objects[$_], refaddr $model->get($iter, 0), "object $_ in model");
        $iter = $model->iter_next($iter);
    };
    
    for (0..9) {
        $widget->select($objects[$_]);
        is(refaddr $widget->get_selected, refaddr $objects[$_], "value set to object $_");
    }
    
    $widget->select(undef);
    ok(!$widget->get_selected, "value set to undefined");
}
