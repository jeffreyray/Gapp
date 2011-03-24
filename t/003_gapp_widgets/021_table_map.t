#!/usr/bin/perl -w
use strict;
use warnings;

use Test::More qw( no_plan );

use Gtk2 '-init';
use_ok 'Gapp::TableMap';

my $map = Gapp::TableMap->new(
    string => '
        +--------------+>>>>>>>>>>>>+
        | 1            | 2          |
        +--------------+            |
        | 3            |            |
        +-------+------+------------+     
        > 4     | 5    | 6          |     
        >       |      +------------+     
        >       |      | 7          |     
        +-------+------+------------+     
        > 8     |      | 9          |      
        >       |      +------------+     
        >       |      | 10         |      
        >       +------+------------+      
        >       | 11                |     
        +-------+-------------------+    
    ',
);

ok $map, 'created map';
is scalar @{$map->cells}, 11, 'created 11 cells';


