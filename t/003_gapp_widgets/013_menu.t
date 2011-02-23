#!/usr/bin/perl -w
use strict;
use warnings;

use Test::More qw( no_plan );

use Gtk2 '-init';
use_ok 'Gapp::Menu';

use Gapp;

my $w = Gapp::Menu->new(
    content => [
        Gapp::ImageMenuItem->new( label => 'New', icon => 'gtk-new' ),
        Gapp::ImageMenuItem->new( label => 'Edit', icon => 'gtk-edit' ),
        Gapp::ImageMenuItem->new( label => 'Delete', icon => 'gtk-delete' ),
    ]
);
ok $w, 'created gapp widget';
ok $w->gtk_widget, 'created gtk widget';

