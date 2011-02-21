#!/usr/bin/perl -w
use strict;
use warnings;

use Test::More qw( no_plan );

use Gtk2 '-init';
use Gapp;
use_ok 'Gapp::ActionGroup';

my $w = Gapp::ActionGroup->new(
    actions => [
        Gapp::Action->new(
            name => 'new',
            label => 'New',
            icon => 'gtk-new'
        )
    ]
);


ok $w, 'created gapp widget';
ok $w->gtk_widget, 'created gtk widget';
