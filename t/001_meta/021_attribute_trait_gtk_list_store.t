use Test::More 'no_plan';
use warnings;
use strict;

package Foo;
use Test::More;

use Gapp::Moose::Gtk2;
use MooseX::Method::Signatures;

widget 'list_store' => (
    is => 'rw',
    traits => [qw( GtkListStore )],
    columns => [qw( Glib::String Glib::String Glib::String Glib::String )],
);

package main;

my $o = Foo->new;
ok $o, 'created object';

1;
