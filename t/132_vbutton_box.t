#!/usr/bin/perl -w
use strict;
use warnings;

use Test::More tests => 1;

use Gapp;

my $w = Gapp::VButtonBox->new;

ok $w, 'created button box';
$w->show_all;
