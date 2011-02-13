use Test::More tests => 2;
use warnings;
use strict;

package Foo;
use Test::More;

use Gapp;
use MooseX::Method::Signatures;

widget 'menu' => (
    is => 'rw',
    traits => [qw( GtkMenu )],
);

package main;

my $o = Foo->new;
ok $o, 'created gapp object';
ok $o->menu, 'retrieved gtk widget';

1;
