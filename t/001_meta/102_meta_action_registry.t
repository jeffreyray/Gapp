#!/usr/bin/perl -w
use strict;
use warnings;

use Test::More qw( no_plan );

use Gapp::Meta::Action;
use_ok 'Gapp::Meta::Action::Registry';

my $action = Gapp::Meta::Action->new(
    name => 'New',
    label => 'New',
    icon => 'gtk-new',
    code => sub {
        my ( $action, $arg ) = @_;
        $$arg++;
    }
);

my $registry = Gapp::Meta::Action::Registry->new;
$registry->add_action( $action );
ok $registry->has_action( 'New' ), 'action added to registry';
ok $registry->action( 'New' )->name, 'retrieved action';
ok $registry->actions, 'retrieved actions';
ok $registry->action_list, 'retrieved action list';