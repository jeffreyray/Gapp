use Test::More 'no_plan';
use warnings;
use strict;

package My::App::Object;
use Test::More;

use Gapp;
use MooseX::Method::Signatures;



widget 'ui_manager' => (
    is => 'rw',
    files => [ 't/basic.ui' ],
    traits => [ qw/GtkUIManager/ ],
    actions => [
        [new      => 'New'    , 'New'    , 'gtk-new'     ],
        [edit     => 'Edit'   , 'Edit'   , 'gtk-edit'    ],
        [delete   => 'Delete' , 'Delete' , 'gtk-delete'  ],
    ]
);

package main;

my $o = My::App::Object->new;
ok $o, 'created object';

ok $o->ui_manager, 'created action group widget';
isa_ok $o->ui_manager, 'Gtk2::UIManager';



1;
