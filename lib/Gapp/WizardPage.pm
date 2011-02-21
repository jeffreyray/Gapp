package Gapp::WizardPage;
use Gapp::Moose::Gtk2;


use Gapp::Types qw( GtkWidget );
use MooseX::Types::Moose qw( Str );

has 'title' => (
    is => 'rw',
    isa => Str,
);

has 'content' => (
    is => 'rw',
    isa => GtkWidget,
);

has 'side_image' => (
    is => 'rw',
    isa => GtkWidget,
);

has 'type' => (
    is => 'rw',
    isa => Str,
    default => 'content',
);


