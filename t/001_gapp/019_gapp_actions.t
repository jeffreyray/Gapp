use Test::More 'no_plan';
use warnings;
use strict;

package Foo::Actions::Basic;
use Gapp::Actions; # -declare => [qw( New Edit Delete )];


action 'New' => (
    label => 'New',
    tooltip => 'New',
    icon => 'gtk-new',
    code => sub {
        ${$_[1]}++;
    },
);

action 'Edit' => (
    label => 'New',
    tooltip => 'New',
    icon => 'gtk-new',
    code => sub {
        ${$_[1]}++;
    },
);

action 'Delete' => (
    label => 'New',
    tooltip => 'New',
    icon => 'gtk-new',
    code => sub {
        ${$_[1]}++;
    },
);

package main;
Foo::Actions::Basics->import( qw( New Edit Delete ) );

ok (Foo::Actions::Basic->retrieve( 'New' ), qq[set/get action 'new']) ;
ok (Foo::Actions::Basic->retrieve( 'Edit' ), qq[set/get action 'edit']);
ok (Foo::Actions::Basic->retrieve( 'Delete' ), qq[set/get action 'delete']);

my $x = 0;
Foo::Actions::Basic->perform( 'New', \$x );
is $x, 1, qq[performed action 'new'];
Foo::Actions::Basic->perform( 'Edit', \$x );
is $x, 2, qq[performed action 'edit'];
Foo::Actions::Basic->perform( 'Delete', \$x );
is $x, 3, qq[performed action 'delete'];

New;

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

package main;
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

#Foo::Actions::Basic->perform( 'New' );
#Foo::Actions::Basic->perform( 'New' );
#Foo::Actions::Basic->perform( 'New' );
##
#
#my $o = My::App::Object->new;
#ok $o, 'created object';
#
#ok $o->ui_manager, 'created action group widget';
#isa_ok $o->ui_manager, 'Gtk2::UIManager';





1;
