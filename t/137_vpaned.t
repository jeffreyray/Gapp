#!/usr/bin/perl -w
use strict;
use warnings;

use Test::More tests => 2;

use Gapp;

my $w = Gapp::VPaned->new;

isa_ok $w, 'Gapp::VPaned';
isa_ok $w->gobject,  'Gtk2::VPaned';
