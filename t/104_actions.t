#!/usr/bin/perl -w
use strict;
use warnings;

use lib 'lib';
use lib 't/lib';
use Test::More qw( no_plan );

use Gapp::Actions::Test qw( New Edit Delete );

isa_ok (New, 'Gapp::Meta::Action');

my $x = 0;
do_New( \$x );
is $x, 1, 'performed action';