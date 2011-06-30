#!/usr/bin/perl -w
use strict;
use warnings;

use Test::More tests => 1;

use Gapp;

{   # create button box
    my $w = Gapp::HButtonBox->new;
    ok $w, 'created button box';
}

{
    use Gapp::Actions -declare => [qw( Apply Cancel Ok )];
    
    action Apply => (
        name => 'Apply',
        label => 'Apply',
        tooltip => 'Apply',
        icon => 'gtk-apply',
        code => sub {
            my ( $action, $widget, $userargs, $gtkw, $gtkargs ) = @_;
            my $form = $widget->form;
            $form->apply;
        }
    );
    
    action Cancel => (
        name => 'Cancel',
        label => 'Cancel',
        tooltip => 'Cancel',
        icon => 'gtk-cancel',
        code => sub {
            my ( $action, $widget, $userargs, $gtkw, $gtkargs ) = @_;
            my $form = $widget->form;
            $form->cancel;
        }
    );
    
    action Ok => (
        name => 'Ok',
        label => 'Ok',
        tooltip => 'Ok',
        icon => 'gtk-ok',
        code => sub {
            my ( $action, $widget, $userargs, $gtkw, $gtkargs ) = @_;
            my $form = $widget->form;
            $form->ok;
        }
    );
    
    # create button box using buttons property
    my $w = Gapp::HButtonBox->new(
        buttons => [ Apply, Cancel, Ok ]
    );
    ok $w, 'created button box';
    
    my $window = Gapp::Window->new( content => [$w] );
    $window->show_all;
    Gapp->main;
}