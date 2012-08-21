#!/usr/bin/perl -w
use strict;
use warnings;

use Test::More tests => 4;

use Gtk2 '-init';
use_ok 'Gapp::TextView';

use Scalar::Util qw(refaddr);

{ # widget construction
    my $w = Gapp::TextView->new;
    isa_ok $w, q[Gapp::TextView];
    isa_ok $w->gobject, q[Gtk2::TextView];
}


{ # buffer
    my $b = Gapp::TextBuffer->new;
    my $w = Gapp::TextView->new( buffer => $b );
    
    is refaddr $w->gobject->get_buffer, refaddr $b->gobject, q[gobject buffer set from attr];
}
