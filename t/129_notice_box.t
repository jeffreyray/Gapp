#!/usr/bin/perl -w
use strict;
use warnings;

use Test::More qw( no_plan );

use Gapp;
use Gapp::Notice;
use_ok 'Gapp::NoticeBox';

{ # basic test
    my $w = Gapp::NoticeBox->new;
    ok $w, 'created gapp window';
    ok $w->gtk_widget, 'created gtk widget';
    
    my $notice = Gapp::Notice->new( image => 'gtk-new', text => 'Hello World!', action =>
        Gapp::Action->new( code => sub { print qq[action\n] } ),
    );
    $w->display( $notice );
    
    Glib::Timeout->add(5000, sub {
        $w->hide;
    });
}

