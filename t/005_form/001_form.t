#!/usr/bin/perl -w
use strict;
use warnings;

package Employee;
use Moose;

has 'first_name' => (
    is => 'rw',
);

use Test::More qw( no_plan );

use Gtk2 '-init';

use Gapp;
use Gapp::Form::Context;

my $cx = Gapp::Form::Context->new;
ok $cx, 'created context';

my $e = Employee->new( first_name => 'Homer' );
$cx->add_node( 'employee', $e, );

my $form = Gapp::VBox->new (
    traits => [qw( Form )],
    context => $cx,
    #context => {
    #    nodes => {
    #        employee => [ $e,
    #            get_prefix =>
    #        ],
    #        facility => { content => $f },
    #    }
    #},
    content => [
        Gapp::VBox->new(
            content => [
                Gapp::Entry->new(
                    field => 'employee.first_name',
                ),
            ]
        )
    ]
);

ok $form, 'created form object';
ok $form->find_fields, 'found form fields';
$form->update;

Gapp::Window->new(
    content => [ $form ]
)->show_all;

Gtk2->main;

