#!/usr/bin/perl -w
use strict;
use warnings;

use Gtk2 '-init';
use lib qw( lib examples/lib );

package My::Assistant;

use Gapp::Moose::Gtk2;
use MooseX::Method::Signatures;

widget 'simple_assistant' => (
    is => 'ro',
    traits => [qw( GtkAssistant DefaultWidget )],
    properties => {
        title => 'Assistant',
    },
    signal_connect => [
        ['delete-event' => sub { $_[0]->destroy }],
        ['close' =>  sub { $_[0]->destroy }],
        ['cancel' =>  sub { $_[0]->destroy }],
        ['destroy' => sub { Gtk2->main_quit }],
    ],
    pages => [
        [ 'intro', 'Intro', 'intro', 'gtk-help', \&_build_intro_page ],
        [ 'content', 'Content', 'content', 'gtk-help', \&_build_content_page ],
        [ 'summary', 'Summary', 'summary', 'gtk-help', \&_build_summary_page],
    ],
    lazy => 1,
);


sub _build_intro_page {
    my ( $self, $assistant, $page ) = @_;
    my $label = Gtk2::Label->new( 'Intro.' );
    $page->add( $label );
}

sub _build_content_page {
    my ( $self, $assistant, $page ) = @_;
    my $label = Gtk2::Label->new( 'Content.' );
    $page->add( $label );
}

sub _build_summary_page {
    my ( $self, $assistant, $page ) = @_;
    my $label = Gtk2::Label->new( 'Summary.' );
    $page->add( $label );
}


package main;

my $gapp_object = My::Assistant->new;
$gapp_object->show_all;

Gtk2->main;
