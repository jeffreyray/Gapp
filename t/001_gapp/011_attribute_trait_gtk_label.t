use Test::More 'no_plan';
use warnings;
use strict;

package My::App::Object;
use Test::More;

use Gapp;
use MooseX::Method::Signatures;

widget 'window' => (
    is => 'rw',
    traits => [ qw/GtkWindow/ ],
    icon => 'gtk-ok',
    properties =>  {
        title => 'Gapp Window',
    },
    build => '_build_window',
);

widget 'label' => (
    is => 'rw',
    class => 'Gtk2::Label',
    traits => [ qw/GtkLabel/ ],
    text => 'Hello World!',
    lazy => 1,
);

method _build_window ( $w ) {
    $w->add( $self->label );
}





package main;

my $o = My::App::Object->new;
ok $o, 'created object';

ok $o->window, 'created window widget';
isa_ok $o->window, 'Gtk2::Window';
is $o->window->get_title, 'Gapp Window', 'title set'; 

ok $o->label, 'created label widget';
isa_ok $o->label, 'Gtk2::Label';
is $o->label->get_text, 'Hello World!', 'text set';

$o->window->show_all;

Gtk2->main;

1;
