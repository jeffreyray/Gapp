#!/usr/bin/perl -w
use strict;
use warnings;

use Test::More qw( no_plan );

use Gtk2 '-init';
use_ok 'Gapp::CellRenderer';

use Gapp;

my $w = Gapp::CellRenderer->new(
    gclass => 'Gtk2::CellRendererText',
    property => 'text',
);
ok $w, 'created gapp widget';
ok $w->gobject, 'created gtk widget';

