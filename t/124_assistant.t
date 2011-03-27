#!/usr/bin/perl -w
use strict;
use warnings;

use Test::More qw( no_plan );

use Gtk2 '-init';
use_ok 'Gapp::Assistant';
use_ok 'Gapp::AssistantPage';

use Gapp;

my $w = Gapp::Assistant->new(
    content => [
        Gapp::AssistantPage->new( name => 'page', title => 'Gapp', type => 'intro' ),
    ]
);
ok $w, 'created gapp widget';
ok $w->gtk_widget, 'created gtk widget';

