#!/usr/bin/perl -w
use strict;
use warnings;

use Test::More tests => 4;

use Gtk2 '-init';
use_ok 'Gapp::TextBuffer';

use Scalar::Util qw(refaddr);

#use Gapp;
{
    my $w = Gapp::TextBuffer->new;
    isa_ok $w, q[Gapp::TextBuffer];
    isa_ok $w->gobject, q[Gtk2::TextBuffer];
}


{ # with TextTagTable
    my $t = Gapp::TextTagTable->new;
    
    my $w = Gapp::TextBuffer->new( tag_table => $t );
    is refaddr $w->gobject->get_tag_table, refaddr $t->gobject, q[tag_table assigned to buffer];
}
