use Test::More tests => 2;
use warnings;
use strict;


package Custom::Page;

use Moose;
extends 'Gapp::Meta::GtkAssistantPage';

package Foo;
use Test::More;

use Gapp;
use MooseX::Method::Signatures;

widget 'assistant' => (
    is => 'rw',
    traits => [qw( GtkAssistant )],
    pages => [
        ['page1', 'Title', 'intro', 'gtk-help', 'Custom::Page' ],
    ]
);



package main;

my $o = Foo->new;
ok $o, 'created gapp object';
ok $o->assistant, 'retrieved gtk widget';

1;
