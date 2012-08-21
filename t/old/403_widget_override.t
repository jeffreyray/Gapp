use Test::More 'no_plan';
use warnings;
use strict;

package Foo::Bar;
use Gapp::Moose;

widget 'window' => (
    is => 'rw',
    traits => [qw( GappWindow )],
    construct => [
        title => 'Original',
    ]
);


package Foo::Bar::Baz;
use Gapp::Moose;

widget 'window' => (
    is => 'rw',
    traits => [qw( GappWindow )],
    construct => [
        title => 'Subclass',
    ]
);



package main;

{ # basic override
    my $o = Foo::Bar->new( window => Gapp::Window->new( title => 'Override') );
    ok $o, 'created object';
    ok $o->window, 'created widget';
    isa_ok $o->window, 'Gapp::Window', 'widget';
    is $o->window->gobject->get_title, 'Override', 'widget overridden';
}

{ # basic subclass
    my $o = Foo::Bar::Baz->new(  );
    ok $o, 'created object';
    ok $o->window, 'created widget';
    isa_ok $o->window, 'Gapp::Window', 'widget';
    is $o->window->gobject->get_title, 'Subclass', 'widget subclassed';
}

{ # subclass with override
    my $o = Foo::Bar::Baz->new( window => Gapp::Window->new( title => 'Override') );
    ok $o, 'created object';
    ok $o->window, 'created widget';
    isa_ok $o->window, 'Gapp::Window', 'widget';
    is $o->window->gobject->get_title, 'Override', 'widget subclassed';
}


1;
