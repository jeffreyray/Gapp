use Test::More 'no_plan';
use warnings;
use strict;

package Foo;
use Test::More;

use Gapp::Moose::Gtk2;
use MooseX::Method::Signatures;



widget 'status_icon' => (
    is => 'rw',
    traits => [qw( GtkStatusIcon )],
    icon => 'gtk-info',
    tooltip => 'Gapp Application',
);

package main;

my $o = Foo->new;
ok $o, 'created object';

ok $o->status_icon, 'created action group widget';
isa_ok $o->status_icon, 'Gtk2::StatusIcon';



1;
