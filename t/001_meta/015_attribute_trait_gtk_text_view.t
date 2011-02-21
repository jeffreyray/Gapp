use Test::More 'no_plan';
use warnings;
use strict;

package My::App::Object;
use Test::More;

use Gapp::Moose::Gtk2;
use MooseX::Method::Signatures;


widget 'text_view' => (
    is => 'rw',
    traits => [ qw/GtkTextView/ ],
);



package main;

my $o = My::App::Object->new;
ok $o, 'created object';

ok $o->text_view, 'created text view widget';
isa_ok $o->text_view, 'Gtk2::TextView';

1;
