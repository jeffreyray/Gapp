package Gapp::Meta::Action::Undefined;

use Moose;
use MooseX::SemiAffordanceAccessor;
use MooseX::StrictConstructor;
use MooseX::Method::Signatures;

use Carp;

use MooseX::Types::Moose qw( CodeRef HashRef Object Str  );

has 'name'  => (
    is => 'rw',
    isa => Str,
    default => '',
);

method perform ( @args ) {
    carp 'you are calling "perform" on an undefind action (' . $_[0]->name . ')';
}

no Moose;
__PACKAGE__->meta->make_immutable;

1;
