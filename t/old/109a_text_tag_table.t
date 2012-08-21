#!/usr/bin/perl -w
use strict;
use warnings;

use Test::More tests => 3;

use Gtk2 '-init';
use_ok 'Gapp::TextTagTable';

#use Gapp;

my $w = Gapp::TextTagTable->new;
isa_ok $w, q[Gapp::TextTagTable];
isa_ok $w->gobject, q[Gtk2::TextTagTable];

