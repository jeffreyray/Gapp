#!/usr/bin/perl -w
use strict;
use warnings;

use Test::More qw( no_plan );

use Gtk2 '-init';

use Gtk2::Ex::FormFactory;

my $table = Gtk2::Ex::FormFactory::Table->new(
    layout => q[
        +---------------+-----------------+
        | Value         |                 |
        +---------------+-----------------+
        |               |                 |
        +---------------+-----------------+
    ],
    content => [
        Gtk2::Ex::FormFactory::Entry->new,
    ]
);
use Data::Dumper;
print Dumper $table->get_widget_table_attach;


