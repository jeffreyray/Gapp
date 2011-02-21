use Test::More 'no_plan';
use warnings;
use strict;

package My::App::Object;

use Test::More;

use Gapp::Moose::Gtk2;
use MooseX::Method::Signatures;

widget 'window' => (
    is => 'rw',
    class => 'Gtk2::Window',
    properties =>  {
        title => 'Gapp Window',
    },
    signal_connect => [
        ['delete-event' => sub { Gtk2->main_quit }],
    ],
    build => '_build_window',
);

widget 'label' => (
    is => 'rw',
    class => 'Gtk2::Label',
    args => [ 'Hello World!'],
    build => '_build_label',
    lazy => 1,
);

method _build_window ( $w ) {
    $w->add( $self->label );
}

method _build_label( $w ) {
    $w->set_text( 'Changed' );
}



package main;

my $o = My::App::Object->new;
ok $o, 'created object';

is $o->label->get_text, 'Changed', 'lazy widget build called';

$o->window->show_all;

1;
