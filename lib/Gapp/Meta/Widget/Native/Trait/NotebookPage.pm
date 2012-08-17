package Gapp::Meta::Widget::Native::Trait::NotebookPage;

use Moose::Role;
use MooseX::SemiAffordanceAccessor;


has 'detachable' => (
    is => 'rw',
    isa => 'Maybe[Bool]',
);

has 'menu_label' => (
    is => 'rw',
    isa => 'Maybe[Gapp::Widget]',
);

has 'position' => (
    is => 'rw',
    isa => 'Maybe[Int]',
);

has 'reorderable' => (
    is => 'rw',
    isa => 'Maybe[Bool]',
);

has 'tab_expand' => (
    is => 'rw',
    isa => 'Maybe[Bool]',
);

has 'tab_fill' => (
    is => 'rw',
    isa => 'Maybe[Bool]',
);

has 'tab_label' => (
    is => 'rw',
    isa => 'Maybe[Bool]',
);

has 'tab_pack' => (
    is => 'rw',
    isa => 'Maybe[Str]'
);

has 'page_name' => (
    is => 'rw',
    isa => 'Str',
    default => '',
);


package Gapp::Meta::Widget::Custom::Trait::NotebookPage;
sub register_implementation { 'Gapp::Meta::Widget::Native::Trait::NotebookPage' };


1;