#!/usr/bin/perl -w
use strict;
use warnings;

package Gapp::Actions::Test::Util;
use Test::More qw( no_plan );
use Gapp::Actions::Util;

action 'New' => (
    label => 'New',
    icon => 'gtk-new',
    code => sub{
        print qq[new action fired\n];
    }
);

ok ACTION_REGISTRY( __PACKAGE__ ), 'created action registry';
is ACTION_REGISTRY( __PACKAGE__ )->action( 'New' )->name, 'New', 'created action New';