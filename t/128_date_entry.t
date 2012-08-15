#!/usr/bin/perl -w
use strict;
use warnings;

use Test::More qw( no_plan );

use Gapp '-init';
use_ok 'Gapp::DateEntry';

my $w = Gapp::DateEntry->new( value => '2011-04-12' );
ok $w, 'created gapp widget';
ok $w->gtk_widget, 'created gtk widget';

