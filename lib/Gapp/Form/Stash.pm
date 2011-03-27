package Gapp::Form::Stash;

use Moose;
use MooseX::StrictConstructor;
use MooseX::SemiAffordanceAccessor;


has 'storage' => (
    is => 'bare',
    isa => 'HashRef',
    default => sub { { } },
    traits => [qw( Hash )],
    clearer => 'clear',
    handles => {
        store => 'set',
        fetch => 'get',
        has => 'exists',
        delete => 'delete',
    },
    lazy => 1,
);


1;
