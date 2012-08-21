#!/usr/bin/perl -w
use strict;
use warnings;

use Test::More qw( no_plan );

use Gapp;
use_ok 'Gapp::Notice';

{ # basic test
    my $w = Gapp::Notice->new;
    ok $w, 'created gapp window';
    ok $w->gobject, 'created gtk widget';
}

