package Gapp::ToolItem;

use Moose;
use MooseX::SemiAffordanceAccessor;
extends 'Gapp::Widget';

has '+class' => (
    default => 'Gtk2::ToolItem',
);

has 'action' => (
    is => 'rw',
    isa => 'Maybe[Gapp::Action]',
);


1;
