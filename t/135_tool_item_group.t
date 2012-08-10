#!/usr/bin/perl -w
use strict;
use warnings;

use Test::More tests => 1;

use Gapp;

my $w = Gapp::ToolItemGroup->new;

isa_ok $w, 'Gapp::ToolItemGroup';
isa_ok $w->gtk_widget,  'Gtk2::ToolItemGroup';


