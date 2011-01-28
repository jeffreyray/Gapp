use Test::More 'no_plan';
use warnings;
use strict;

package My::App::Object;
use Test::More;

use Gapp;
use MooseX::Method::Signatures;


widget 'button' => (
    is => 'rw',
    traits => [ qw/GtkButton/ ],
);



package main;

my $o = My::App::Object->new;
ok $o, 'created object';

ok $o->button, 'created text view widget';
isa_ok $o->button, 'Gtk2::Button';

1;
