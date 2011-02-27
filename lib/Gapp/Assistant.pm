package Gapp::Assistant;

use Moose;
use MooseX::SemiAffordanceAccessor;
use MooseX::Types::Moose qw( HashRef );

extends 'Gapp::Window';

has '+class' => (
    default => 'Gtk2::Assistant',
);

1;
