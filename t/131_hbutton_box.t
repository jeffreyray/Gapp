#!/usr/bin/perl -w
use strict;
use warnings;

use Test::More tests => 1;

use Gapp;

my $w = Gapp::HButtonBox->new;

ok $w, 'created button box';
$w->show_all;
