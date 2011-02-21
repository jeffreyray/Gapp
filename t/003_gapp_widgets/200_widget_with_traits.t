#!/usr/bin/perl -w
use strict;
use warnings;

package My::Widget::Trait;
use Moose::Role;

use Gapp;

around BUILDARGS => sub {
    my ( $orig, $class, %opts ) = @_;

    $opts{buttons} = [ 'gtk-yes', 'gtk-no' ];
    
    return $class->$orig( %opts );
};



use Test::More qw( no_plan );

use Gtk2 '-init';
use_ok 'Gapp::VBox';

use Gapp;
my $w = Gapp::Dialog->new( traits => [qw( My::Widget::Trait )] );
ok $w, 'created gapp widget';
ok $w->gtk_widget, 'created gtk widget';
