use Test::More 'no_plan';
use warnings;
use strict;

package My::App::Object;
use Test::More;

use Gapp::Moose::Gtk2;
use MooseX::Method::Signatures;


widget 'toolbar' => (
    is => 'rw',
    traits => [ qw/GtkToolbar/ ],
    style => 'icons',
);



package main;

my $o = My::App::Object->new;
ok $o, 'created object';

ok $o->toolbar, 'created toolbar widget';
isa_ok $o->toolbar, 'Gtk2::Toolbar';

1;
