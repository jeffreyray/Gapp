#!/usr/bin/perl -w
use strict;
use warnings;

use Test::More qw( no_plan );

use Gapp '-init';
use_ok 'Gapp::SSNEntry';

my $w = Gapp::SSNEntry->new( value => '999-99-9999' );
ok $w, 'created gapp widget';
ok $w->gtk_widget, 'created gtk widget';

