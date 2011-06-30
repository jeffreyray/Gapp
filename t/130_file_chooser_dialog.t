#!/usr/bin/perl -w
use strict;
use warnings;

use Test::More qw( no_plan );

use Gapp;

my $w = Gapp::FileChooserDialog->new(
    title => 'Gapp',
    buttons => [ 'gtk-cancel', 'gtk-open' ],
);

ok $w, 'created file chooser dialog';
$w->show_all;

Gapp->main;
