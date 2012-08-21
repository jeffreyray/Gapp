#!/usr/bin/perl -w
use strict;
use warnings;

use Test::More tests => 3;

use Gtk2 '-init';
use_ok 'Gapp::Menu';

my $w = Gapp::Menu->new;
isa_ok $w, 'Gapp::Menu';
isa_ok $w->gobject, 'Gtk2::Menu';
