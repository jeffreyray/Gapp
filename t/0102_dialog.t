#!/usr/bin/perl -w
use strict;
use warnings;

use Test::More tests => 3;

use Gtk2 '-init';
use_ok 'Gapp::Dialog';

my $w = Gapp::Dialog->new(
    title => 'Gapp',
    buttons => [ 'gtk-yes', 'gtk-no' ],

);

isa_ok $w, 'Gapp::Dialog';
isa_ok $w->gobject, 'Gtk2::Dialog';
