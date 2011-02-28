#!/usr/bin/perl -w
use strict;
use warnings;

use Test::More qw( no_plan );

use Gtk2 '-init';
use_ok 'Gapp::CellRenderer';

use Gapp;

my $w = Gapp::CellRenderer->new(
    class => 'Gtk2::CellRendererText',
    property => 'text',
);
ok $w, 'created gapp widget';
ok $w->gtk_widget, 'created gtk widget';

