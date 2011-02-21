package Gapp::VBox;

use Moose;
extends 'Gapp::Container';

use Gapp::Util;
use Moose::Util;

has '+class' => (
    default => 'Gtk2::VBox',
);


1;
