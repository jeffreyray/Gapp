package Gapp::AssistantPage;

use Moose;
use MooseX::LazyRequire;
use MooseX::SemiAffordanceAccessor;
use MooseX::Types::Moose qw( HashRef );

extends 'Gapp::VBox';

has 'name' => (
    is => 'rw',
    isa => 'Str',
    default => '',
);

has 'title' => (
    is => 'rw',
    isa => 'Str',
    default => '',
);

has 'type' => (
    is => 'rw',
    isa => 'Str',
    default => '',
    lazy_required => 1,
);

has 'icon' => (
    is => 'rw',
    isa => 'Str',
    default => '',
);



1;
