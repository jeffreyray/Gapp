#!/usr/bin/perl -w
use strict;
use warnings;

use Test::More qw( no_plan );

use Gtk2 '-init';
use_ok 'Gapp::UIManager';

my $w = Gapp::UIManager->new;
ok $w, 'created gapp widget';
ok $w->gobject, 'created gtk widget';