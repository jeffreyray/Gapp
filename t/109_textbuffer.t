#!/usr/bin/perl -w
use strict;
use warnings;

use Test::More tests => 3;

use Gtk2 '-init';
use_ok 'Gapp::TextBuffer';

#use Gapp;

my $w = Gapp::TextBuffer->new;
isa_ok $w, q[Gapp::TextBuffer];
isa_ok $w->gtk_widget, q[Gtk2::TextBuffer];

