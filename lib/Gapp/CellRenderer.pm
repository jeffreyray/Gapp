package Gapp::CellRenderer;

use Moose;
use MooseX::LazyRequire;
use MooseX::SemiAffordanceAccessor;


extends 'Gapp::Widget';

has 'property' => (
    is => 'rw',
    isa => 'Str',
    lazy_required => 1,
);

1;
