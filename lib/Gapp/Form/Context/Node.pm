package Gapp::Form::Context::Node;

use Moose;
use MooseX::SemiAffordanceAccessor;

has 'content' => (
    is => 'rw',
);

has 'get_prefix' => (
    is => 'rw',
    isa => 'Str',
    default => '',
);

has 'set_prefix' => (
    is => 'rw',
    isa => 'Str',
    default => '',
);

1;
