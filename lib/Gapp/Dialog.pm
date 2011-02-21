package Gapp::Dialog;

use Moose;
use MooseX::SemiAffordanceAccessor;
use MooseX::Types::Moose qw( ArrayRef );

extends 'Gapp::Window';

has 'buttons' => (
    is => 'rw',
    isa => ArrayRef,
    default => sub { [ ] },
);

has '+class' => (
    default => 'Gtk2::Dialog',
);

has '+gtk_widget' => (
    handles => ['run'],
);

after '_build_gtk_widget' => sub {
    print "--->\n";
    shift->gtk_widget->vbox->show_all;
};

1;
