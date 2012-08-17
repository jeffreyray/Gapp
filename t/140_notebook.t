#!/usr/bin/perl -w
use strict;
use warnings;

use Test::More tests => 5;

use Gtk2 '-init';

use Gapp::Label;
use Gapp::VBox;
use Gapp::Window;
use_ok 'Gapp::Notebook';



{ # basic construction test
    my $w = Gapp::Notebook->new;
    isa_ok $w, 'Gapp::Notebook';
    isa_ok $w->gtk_widget,  'Gtk2::Notebook';
}


{ # add pages
    my $page = Gapp::VBox->new(
        traits => [qw( NotebookPage )],
        content => [
            Gapp::Label->new( text => 'Hello World!'),
        ]
    );
    
    ok $page, 'created page';
    
    my $w = Gapp::Notebook->new(
        content => [
            $page
        ]
    );
    
    ok $w, 'created notebook with page';
    
    ok $w->gtk_widget->get_children, 'notebook has page';
    
    Gapp::Window->new( content => [$w] )->show_all;
    Gtk2->main;
}









#{ # construct with groups
#    my $group = Gapp::ToolItemGroup->new(
#        content => [
#            Gapp::ToolButton->new( label => 'Tool Action' ),
#        ]
#    );
#    
#    my $palette = Gapp::ToolPalette->new(
#        content => [
#            $group
#        ]
#    );
#    
#    ok $palette, "Created palette with group";
#}
