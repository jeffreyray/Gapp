#!/usr/bin/perl -w
use strict;
use warnings;

use Test::More qw( no_plan );

use Gtk2 '-init';

use Gapp;

my $form = Gapp::VBox->new (
    traits => [qw( Form )],
    #content => [
    #    Gapp::VBox->new(
    #        content => [
    #            Gapp::Entry->new(
    #                #field => 'employee.first_name'
    #            ),
    #        ]
    #    )
    #]
);


#my $context = Gapp::Form::Context->new(
#    content => [
#        employee => $employee,
#    ]
#);