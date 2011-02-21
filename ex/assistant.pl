#!/usr/bin/perl -w
use Gtk2 '-init';
use strict;
use warnings;


package My::Assistant;

use Gapp::Moose;
use MooseX::SemiAffordanceAccessor;

widget 'assistant' => (
    is => 'rw',
    traits => [qw( GappAssistant )],
    design => {
        title => 'Assistant',
        content => [
            [ 'intro', 'Intro', 'intro', 'gtk-help', '_build_intro_page' ],
            [ 'content', 'Content', 'content', 'gtk-help', '_build_content_page' ],
            [ 'summary', 'Summary', 'summary', 'gtk-help', '_build_summary_page' ],
        ],
        signal_connect => [
            ['delete-event' => sub { $_[0]->destroy }],
            ['close' =>  sub { $_[0]->destroy }],
            ['cancel' =>  sub { $_[0]->destroy }],
            ['destroy' => sub { Gtk2->main_quit }],
        ],
    },
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
