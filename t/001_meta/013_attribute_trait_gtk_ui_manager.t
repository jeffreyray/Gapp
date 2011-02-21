use Test::More 'no_plan';
use warnings;
use strict;

package My::App::Object;
use Test::More;

use Gapp::Moose::Gtk2;
use MooseX::Method::Signatures;



widget 'ui_manager' => (
    is => 'rw',
    files => [ 't/basic.ui' ],
    traits => [ qw/GtkUIManager/ ],
    build => '_build_ui_manager',
);


method _build_ui_manager ( $w ) {
    ok $w, 'calling build method';
}

package main;

my $o = My::App::Object->new;
ok $o, 'created object';

ok $o->ui_manager, 'created action group widget';
isa_ok $o->ui_manager, 'Gtk2::UIManager';

1;
