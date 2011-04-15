#!/usr/bin/perl -w
use strict;
use warnings;

use Test::More qw( no_plan );

use Gtk2 '-init';
use_ok 'Gapp::VBox';

use Gapp;
use Gapp::Meta::Widget::Native::Trait::OkCancelDialog;

my $w = Gapp::Dialog->new(
    traits => [qw( OkCancelDialog )],
    message => 'Undefined blah blah.',
    summary => '',
);

ok $w, 'created gapp widget';
ok $w->gtk_widget, 'created gtk widget';
