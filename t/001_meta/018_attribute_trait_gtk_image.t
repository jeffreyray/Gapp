use Test::More 'no_plan';
use warnings;
use strict;

package My::App::Object;
use Test::More;

use Gapp;
use MooseX::Method::Signatures;


widget 'image' => (
    is => 'rw',
    traits => [ qw/GtkImage/ ],
    stock  => [ 'gtk-new', 'dialog' ],
);



package main;

my $o = My::App::Object->new;
ok $o, 'created object';

ok $o->image, 'created image widget';
isa_ok $o->image, 'Gtk2::Image';

1;
