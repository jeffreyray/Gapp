package Gapp::VBox;

use Moose;
extends 'Gapp::Box';

use Gapp::Util;
use Moose::Util;

has '+class' => (
    default => 'Gtk2::VBox',
);


1;
