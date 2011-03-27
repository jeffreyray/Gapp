#!/usr/bin/perl -w
use strict;
use warnings;

package Employee;
use Moose;

has 'first_name' => (
    is => 'rw',
);

use Test::More qw( no_plan );

use Gtk2 '-init';

use Gapp;
use Gapp::Form::Context;

my $cx = Gapp::Form::Context->new;
ok $cx, 'created context';

my $e = Employee->new( first_name => 'Homer' );
$cx->add_node( 'employee', $e, );

my $w = Gapp::Entry->new( field => 'employee.first_name' );
$cx->update_widget( $w );

