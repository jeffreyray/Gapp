#!/usr/bin/perl -w
use strict;
use warnings;

use Gtk2 '-init';
use lib qw( lib examples/lib );

use Gapp;

my $m = Gapp::ListStore->new(
    columns => [qw( Glib::Boolean Glib::String Glib::String Glib::String )]
);

my $iter = $m->gtk_widget->append;
$m->gtk_widget->set( $iter, 0 => 0, 1 => 60489, 2 => 'Critical', 3 => 'Bug description' );
$m->gtk_widget->set( $iter, 0 => 1, 1 => 60566, 2 => 'Standard', 3 => 'Bug 2' );
$m->gtk_widget->set( $iter, 0 => 0, 1 => 60569, 2 => 'Critical', 3 => 'Antoher bug' );
$m->gtk_widget->set( $iter, 0 => 1, 1 => 60662, 2 => 'Standard', 3 => 'Bugs eveywhere' );
$m->gtk_widget->set( $iter, 0 => 0, 1 => 60783, 2 => 'Critical', 3 => 'Bugs?' );

my $w = Gapp::Window->new(
    title => 'Gapp Application',
    content => [
        Gapp::VBox->new(
            content => [
                Gapp::TreeView->new(
                    columns => [
                        [ 'fixed'      , 'Fixed?'     , 'toggle', 0, undef, ],
                        [ 'bug_number' , 'Bug Number' , 'text', 1, undef],
                        [ 'severity'   , 'Severity'   , 'text', 2, undef],
                        [ 'description', 'Description', 'text', 3, undef],
                    ],
                    customize => sub {
                        my ( $self, $w ) = @_;
                        $self->find_column( 'fixed' )->renderer->signal_connect(
                            toggled => \&_do_toggled, [ $m, 0 ]
                        );
                    },
                    model => $m,
                )
            ]
        )
    ],
    signal_connect => [
        ['delete-event' => sub { Gtk2->main_quit }],
    ]
);



sub _do_toggled {
    print @_, "\n";
    my ( $r, $cell, $path_str, $args ) = @_;
    my ( $model, $col ) = $args ? @$args : ();
    my $path = Gtk2::TreePath->new( $path_str );
    my $iter = $model->gtk_widget->get_iter( $path );
    
    my ( $value ) = $model->gtk_widget->get( $iter, $col );
    $value ^= 1;
    
    $model->gtk_widget->set( $iter, $col, $value );
    
}

$w->show_all;


Gtk2->main;
