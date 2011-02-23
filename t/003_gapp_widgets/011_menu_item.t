#!/usr/bin/perl -w
use strict;
use warnings;

use Test::More qw( no_plan );

use Gtk2 '-init';
use_ok 'Gapp::MenuItem';

my $w = Gapp::MenuItem->new( label => 'new' );
ok $w, 'created gapp widget';
ok $w->gtk_widget, 'created gtk widget';

