#!/usr/bin/perl -w
use strict;
use warnings;


use Test::More qw( no_plan );

use_ok 'Gapp::Action';

my $action = Gapp::Action->new(
    name => 'New',
    label => 'New',
    icon => 'gtk-new',
    code => sub {
        my ( $action, $arg ) = @_;
        $$arg++;
    }
);

ok $action, 'created action';
is $action->name, 'New', 'action name set';
is $action->label, 'New', 'action label set';
is $action->icon, 'gtk-new', 'action icon set';
ok $action->code, 'action code set';

my $x = 0;
$action->perform( \$x );
is $x, 1, 'performed action';