use Test::More 'no_plan';
use warnings;
use strict;

package My::App::Object;

use Test::More;
use_ok 'Gapp';


package main;

my $o = My::App::Object->new;
ok $o, 'created object instance';
isa_ok $o, 'My::App::Object', 'isa My::App::Object';
isa_ok $o, 'Gapp::Object', 'isa Gapp::Object';






1;
