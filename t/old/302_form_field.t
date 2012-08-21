#!/usr/bin/perl -w
use strict;
use warnings;

use Test::More qw( no_plan );

use Gtk2 '-init';

use Gapp;

my $e = Gapp::Entry->new( );

ok $e->does( 'Gapp::Meta::Widget::Native::Role::FormField' ), 'entry does FormField';
ok $e->can( 'field' ), 'has field attribute';