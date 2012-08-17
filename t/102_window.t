#!/usr/bin/perl -w
use strict;
use warnings;

use Test::More qw( no_plan );

use Gtk2 '-init';
use_ok 'Gapp::Window';

{ # basic test
    my $w = Gapp::Window->new;
    ok $w, 'created gapp window';
    ok $w->gobject, 'created gtk widget';
}

{ # transient for
    my $t = Gapp::Window->new;
    my $w = Gapp::Window->new( transient_for => $t, position => 'center' );
    ok $w, 'created gapp window';
    ok $w->gobject, 'created gtk widget';
    ok $w->gobject->get_transient_for, 'set window transient for';
    ok $w->gobject->get_position, 'set window position';
}


