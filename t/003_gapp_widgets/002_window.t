#!/usr/bin/perl -w
use strict;
use warnings;

use Test::More qw( no_plan );

use Gtk2 '-init';
use_ok 'Gapp::Window';

my $w = Gapp::Window->new;
ok $w, 'created gapp window';
ok $w->gtk_widget, 'created gtk widget';

