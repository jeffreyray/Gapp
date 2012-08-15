#!/usr/bin/perl -w
use strict;
use warnings;

use Test::More tests => 2;

use Gapp;

my $w = Gapp::HPaned->new;

isa_ok $w, 'Gapp::HPaned';
isa_ok $w->gtk_widget,  'Gtk2::HPaned';
