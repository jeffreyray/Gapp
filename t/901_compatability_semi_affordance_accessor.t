use Test::More 'no_plan';
use warnings;
use strict;

package My::App::Object;

use Test::More;

use Gapp::Moose::Gtk2;

widget 'window' => (
    is => 'rw',
    class => 'Gtk2::Window',
    properties =>  {
        title => 'Gapp Window',
    },
    build => sub {
        my ( $self, $w ) = @_;
        $w->add( $self->label );
    },
);

widget 'label' => (
    is => 'rw',
    class => 'Gtk2::Label',
    args => [ 'Hello World!'],
    lazy => 1,
);


package main;

my $o = My::App::Object->new;
ok $o, 'created object';

ok $o->window, 'created window widget';
isa_ok $o->window, 'Gtk2::Window';
is $o->window->get_title, 'Gapp Window', 'title set'; 

ok $o->label, 'created label widget';
isa_ok $o->label, 'Gtk2::Label';
is $o->label->get_text, 'Hello World!', 'text set';

1;
