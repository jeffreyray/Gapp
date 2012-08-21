#!/usr/bin/perl -w
use strict;
use warnings;

use Test::More qw( no_plan );

use Gtk2 '-init';
use Gapp::ListStore;
use_ok 'Gapp::TreeView';

use Gapp;

my $w = Gapp::TreeView->new(
    model => Gapp::ListStore->new( columns => [ 'Glib::String' ] ),
    columns => [
        Gapp::TreeViewColumn->new(
            name => 'id',
            title => 'ID',
            renderer => 'text',
        ),
    ]
);
ok $w, 'created gapp widget';
ok $w->gobject, 'created gtk widget';

print $w->gobject->get_children, "\n";