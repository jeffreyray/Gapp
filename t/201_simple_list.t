#!/usr/bin/perl -w
use strict;
use warnings;

use lib 'lib';
use lib 't/lib';
use Test::More qw( no_plan );

use_ok 'Gapp::Model::SimpleList';

my $model = Gapp::Model::SimpleList->new;
my $iter = $model->append( 'value 1' );
is $model->get( $iter ), 'value 1', 'value set/retrieved';

$model->set( $iter, 'updated' );
is $model->get( $iter ), 'updated', 'value set/updated';