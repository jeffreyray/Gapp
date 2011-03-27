#!/usr/bin/perl -w
use strict;
use warnings;

use Test::More qw( no_plan );

use Gtk2 '-init';
use_ok 'Gapp::ComboBox';

use Gapp;

my $w = Gapp::ComboBox->new(
    values => [
        'foo',
        'bar',
        'baz',
    ]
);
ok $w, 'created gapp widget';
ok $w->gtk_widget, 'created gtk widget';

my $model = $w->gtk_widget->get_model;
my $iter = $model->get_iter_first;
ok $model->get( $iter, 0 ), 'got foo';

$iter = $model->iter_next( $iter );
ok $model->get( $iter, 0 ), 'got bar';

$iter = $model->iter_next( $iter );
ok $model->get( $iter, 0 ), 'got baz';

