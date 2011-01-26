use Test::More 'no_plan';
use warnings;
use strict;

package Foo::Actions::Basic;
use Gapp::Actions;


action 'New' => (
    label => 'New',
    tooltip => 'New',
    icon => 'gtk-new',
    code => sub {
        print "New\n",
    },
);

action 'Edit' => (
    label => 'New',
    tooltip => 'New',
    icon => 'gtk-new',
    code => sub {
        print "New\n",
    }
);

action 'Delete' => (
    label => 'New',
    tooltip => 'New',
    icon => 'gtk-new',
    code => sub {
        print "New\n",
    }
);



#package My::App::Object;
#use Test::More;
#
#use Gapp;
#use MooseX::Method::Signatures;
#
#
#
#widget 'ui_manager' => (
#    is => 'rw',
#    files => [ 't/001_gapp/basic.ui' ],
#    traits => [ qw/GtkUIManager/ ],
#    actions => [
#        'Foo::Actions::Basic',
#    ]
#);

#package main;
#use Foo::Actions::Basic qw( New Edit Delete );
#
#my $o = My::App::Object->new;
#New( $o, $w, @args);
#
##ok $o, 'created object';
#
#m
#
##
##my @actions = Foo::Actions::Basic->get_actions;
##
#ok Foo::Action::Basic->get_action( 'New' );
#ok Foo::Action::Basic->get_action( 'Edit' );
#ok Foo::Action::Basic->get_action( 'Delete' );

Foo::Actions::Basic->perform( 'New' );
Foo::Actions::Basic->perform( 'New' );
Foo::Actions::Basic->perform( 'New' );
#
#
#my $o = My::App::Object->new;
#ok $o, 'created object';
#
#ok $o->ui_manager, 'created action group widget';
#isa_ok $o->ui_manager, 'Gtk2::UIManager';





1;
