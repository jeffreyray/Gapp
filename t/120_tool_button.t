#!/usr/bin/perl -w
use strict;
use warnings;

use Test::More qw( no_plan );

use Gtk2 '-init';
use Gapp::Action;
use_ok 'Gapp::ToolButton';

my $w = Gapp::ToolButton->new( icon => 'gtk-new', label => 'new' );
ok $w, 'created gapp widget';
ok $w->gobject, 'created gtk widget';


$w = Gapp::ToolButton->new(
    action => Gapp::Action->new (
        name => 'new',
        label => 'New',
        tooltip => 'New',
        icon => 'gtk-new',
        code => sub {
            print "New\n";
        }
    ),
);
ok $w, 'created gapp widget with action';

