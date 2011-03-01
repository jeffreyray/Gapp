package Gapp::Meta::Widget::Native::Trait::FormField;

use Moose::Role;

has 'field' => (
    is => 'rw',
    isa => 'Str',
    default => '',
);

package Gapp::Meta::Widget::Custom::Trait::FormField;
sub register_implementation { 'Gapp::Meta::Widget::Native::Trait::FormField' };


1;