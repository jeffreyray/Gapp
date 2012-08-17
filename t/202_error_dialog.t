#!/usr/bin/perl -w
use strict;
use warnings;

use Test::More qw( no_plan );

use Gtk2 '-init';
use_ok 'Gapp::VBox';

use Gapp;
use Gapp::Meta::Widget::Native::Trait::ErrorDialog;

my $w = Gapp::Dialog->new(
    traits => [qw( ErrorDialog )],
    message => 'Undefined blah blah.',
    summary => '',
);

ok $w, 'created gapp widget';
ok $w->gobject, 'created gtk widget';
