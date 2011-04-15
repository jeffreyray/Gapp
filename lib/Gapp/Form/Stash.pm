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
        contains => 'exists',
        delete => 'delete',
        elements => 'keys',
    },
    lazy => 1,
);

has 'modified' => (
    is => 'rw',
    isa => 'Bool',
    default => 0,
);

after 'store' => sub { $_[0]->set_modified(1) };
after 'delete' => sub { $_[0]->set_modified(1) };

1;
