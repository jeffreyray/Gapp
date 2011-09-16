#!/usr/bin/perl -w
use strict;
use warnings;
use Test::More tests => 70;

use Gtk2 '-init';
use_ok( 'Gapp::DateEntry' );


my $entry =  Gapp::DateEntry->new( value => '08-11-1986', on_change => sub {
    print "CHANGED\n";
} );


$entry->gtk_widget->set_value( '09-15-1986' );


