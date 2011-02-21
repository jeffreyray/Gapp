package Gapp::HBox;

use Moose;
extends 'Gapp::Container';

use Gapp::Util;
use Moose::Util;

has '+class' => (
    default => 'Gtk2::HBox',
);


1;
