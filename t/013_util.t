use Test::More tests => 3;
use warnings;
use strict;

use_ok 'Gapp::Util';
use Gapp::Util qw(add_handles);

{   # handles, array-array
    my $opts = { handles => [qw( foo bar )] };
    add_handles ( $opts, [qw( biz baz )] );
    
    is_deeply $opts->{handles}, [qw( foo bar biz baz )], q[added handles array-array];
}

{   # handles, array-hash
    my $opts = { handles => [qw( foo bar )] };
    add_handles ( $opts, {qw( biz biz baz baz )} );
    
    is_deeply $opts->{handles}, {qw( foo foo bar bar biz biz baz baz )}, q[added handles hash-array];
}

{   # handles, merge hash-array
    my $opts = { handles => {qw(foo foo bar bar)} };
    add_handles ( $opts, [qw( biz baz )] );
    
    is_deeply $opts->{handles}, {qw( foo foo bar bar biz biz baz baz )}, q[added handles hash-array];
}

{   # handles, merge hash-hash
    my $opts = { handles => {qw(foo foo bar bar)} };
    add_handles ( $opts, {qw( biz biz baz baz )} );
    
    is_deeply $opts->{handles}, {qw( foo foo bar bar biz biz baz baz )}, q[added handles hash-hash];
}



1;
