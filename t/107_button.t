#!/usr/bin/perl -w
use strict;
use warnings;

use Test::More qw( no_plan );

use Gtk2 '-init';
use_ok 'Gapp::Button';

{ # Gapp Button
my $w = Gapp::Button->new( label => 'Label' );
ok $w, 'created gapp widget';
ok $w->gobject, 'created gtk widget';
}




