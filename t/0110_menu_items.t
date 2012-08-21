#!/usr/bin/perl -w
use strict;
use warnings;

use Test::More tests => 3;

use Gtk2 '-init';

{
    use_ok 'Gapp::MenuItem';
    
    my $w = Gapp::MenuItem->new;
    isa_ok $w, 'Gapp::MenuItem';
    isa_ok $w->gobject, 'Gtk2::MenuItem';
}

{
    use_ok 'Gapp::ImageMenuItem';
    
    my $w = Gapp::ImageMenuItem->new;
    isa_ok $w, 'Gapp::ImageMenuItem';
    isa_ok $w->gobject, 'Gtk2::ImageMenuItem';
}

{
    use_ok 'Gapp::SeparatorMenuItem';

    my $w = Gapp::SeparatorMenuItem->new;
    isa_ok $w, 'Gapp::SeparatorMenuItem';
    isa_ok $w->gobject, 'Gtk2::SeparatorMenuItem';
}