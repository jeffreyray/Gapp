#!/usr/bin/perl -w
use strict;
use warnings;

use Test::More tests => 3;

use Gapp;


{ # basic construction test
    my $w = Gapp::ToolPalette->new;
    isa_ok $w, 'Gapp::ToolPalette';
    isa_ok $w->gtk_widget,  'Gtk2::ToolPalette';
}

{ # construct with groups
    my $group = Gapp::ToolItemGroup->new(
        content => [
            Gapp::ToolButton->new( label => 'Tool Action' ),
        ]
    );
    
    my $palette = Gapp::ToolPalette->new(
        content => [
            $group
        ]
    );
    
    ok $palette, "Created palette with group";
}
