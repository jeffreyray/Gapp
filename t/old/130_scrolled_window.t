#!/usr/bin/perl -w
use strict;
use warnings;

use Test::More qw( no_plan );

use Gtk2 '-init';
use Gapp::ListStore;
use Gapp::TreeView;
use_ok 'Gapp::ScrolledWindow';

use Gapp;

my $t = Gapp::TreeView->new(
    model => Gapp::ListStore->new( columns => [ 'Glib::String' ] ),
    columns => [
        Gapp::TreeViewColumn->new(
            name => 'id',
            title => 'ID',
            renderer => 'text',
        ),
    ]
);

my $w = Gapp::ScrolledWindow->new(
    content => [ $t ],
);


ok $w, 'created gapp widget';
ok $w->gobject, 'created gtk widget';
