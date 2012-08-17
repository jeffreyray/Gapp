#!/usr/bin/perl -w
use strict;
use warnings;

use Test::More qw( no_plan );

use Gtk2 '-init';

use Gapp;
use_ok 'Gapp::HBox';

my $w = Gapp::HBox->new;
ok $w, 'created gapp widget';
ok $w->gobject, 'created gtk widget';
