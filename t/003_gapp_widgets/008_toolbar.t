#!/usr/bin/perl -w
use strict;
use warnings;

use Test::More qw( no_plan );

use Gtk2 '-init';
use_ok 'Gapp::Toolbar';

my $w = Gapp::Toolbar->new(
    content => [
        Gapp::ToolButton->new( )
    ]
);


ok $w, 'created gapp widget';
ok $w->gtk_widget, 'created gtk widget';
