#!/usr/bin/perl -w
use strict;
use warnings;

use Test::More qw( no_plan );

use Gtk2 '-init';

use_ok 'Gapp::Widget';

my $w = Gapp::Widget->new( class => 'Gtk2::Window' );
ok $w, 'created gapp widget';
ok $w->gtk_widget, 'created gtk widget';

