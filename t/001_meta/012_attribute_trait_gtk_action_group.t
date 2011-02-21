use Test::More tests => 3;
use warnings;
use strict;

package My::App::Object;
use Test::More;

use Gapp::Moose::Gtk2;
use MooseX::Method::Signatures;



widget 'action_group' => (
    is => 'rw',
    traits => [ qw/GtkActionGroup/ ],
    actions => [
        [new      => 'Employees'    , 'Employees'    , 'gtk-new'     ],
        [edit     => 'Evaluations'  , 'Evaluations'  , 'gtk-edit'    ],
        [delete   => 'Studies'      , 'Studies'      , 'gtk-delete'  ],
        [print    => 'Configuration', 'Configuration', 'gtk-print'   ],
    ]
);


package main;

my $o = My::App::Object->new;
ok $o, 'created object';

ok $o->action_group, 'created action group widget';
isa_ok $o->action_group, 'Gtk2::ActionGroup';

1;
