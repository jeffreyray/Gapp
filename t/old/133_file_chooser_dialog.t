#!/usr/bin/perl -w
use strict;
use warnings;

use Test::More qw( no_plan );


use Gtk2 '-init';
use Gapp::FileChooserDialog;

my $w = Gapp::FileChooserDialog->new(
    title => 'Gapp',
    buttons => [ 'gtk-cancel', 'gtk-open' ],
);

ok $w, 'created file chooser dialog';
