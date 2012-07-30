#!/usr/bin/perl -w
use strict;
use warnings;

use Test::More qw( no_plan );

use Gapp;

my $w = Gapp::SeparatorMenuItem->new( label => 'New' );

my $menu = Gapp::Menu->new(
    content => [
        $w
    ]
);
isa_ok $w->gtk_widget, "Gtk2::SeparatorMenuItem";

