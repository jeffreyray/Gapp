#!/usr/bin/perl -w
use strict;
use warnings;

use Test::More qw( no_plan );

use Gtk2 '-init';
use_ok 'Gapp::TreeViewColumn';

use Gapp;

my $w = Gapp::TreeViewColumn->new(
    name => 'id',
    title => 'ID',
    renderer => 'text',
);
ok $w, 'created gapp widget';
ok $w->gtk_widget, 'created gtk widget';

