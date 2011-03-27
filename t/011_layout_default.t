#!/usr/bin/perl -w
use strict;
use warnings;

package main;
use Test::More qw( no_plan );

use Gapp::Layout::Default;

my $layout =  Gapp::Layout::Default->Layout;
ok ( $layout, 'created layout object' );
ok ( $layout->get_packer( 'Gapp::Widget', 'Gapp::Container' ), 'got packer' );