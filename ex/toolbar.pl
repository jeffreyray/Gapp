#!/usr/bin/perl -w
use strict;
use warnings;

package MyApplicationObject;

use Gapp;
use Gapp::Moose;
use Gapp::Actions -declare => [qw( New Edit Delete )];


action New => (
    label => 'New',
    tooltip => 'New',
    icon => 'gtk-new',
    code => sub { print 'action: ' . $_[0]->name, "\n" },
);

action Edit => (
    label => 'Edit',
    tooltip => 'Edit',
    icon => 'gtk-edit',
    code => sub { print 'action: ' . $_[0]->name, "\n"  },
);

action Delete => (
    label => 'Delete',
    tooltip => 'Delete',
    icon => 'gtk-delete',
    code => sub { print 'action: ' . $_[0]->name, "\n"  },
);

my $w = Gapp::Window->new(
    content => [
        Gapp::Toolbar->new(
            content => [
                Gapp::ToolButton->new( action => New ),
                Gapp::ToolButton->new( action => Edit ),
                Gapp::ToolButton->new( action => Delete ),
            ]
        )
    ]
);

$w->show_all;

Gtk2->main;
