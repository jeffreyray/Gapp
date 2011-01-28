package Gapp::Meta::Action::Undefined;

use Moose;
use MooseX::SemiAffordanceAccessor;
use MooseX::StrictConstructor;
use MooseX::Method::Signatures;

use Carp;

use MooseX::Types::Moose qw( CodeRef HashRef Object Str Undef  );

has 'name'  => (
    is => 'rw',
    isa => Str,
    default => '',
);

has [qw( label tooltip )] => (
    is => 'ro',
    isa => Str,
    default => '',
);

has 'code' => (
    is => 'ro',
    isa => CodeRef,
    default => sub { sub { } },
);

has 'icon' => (
    is => 'ro',
    isa => Str|Undef,
    default => undef,
);

method perform ( @args ) {
    carp 'you are calling "perform" on an undefind action (' . $_[0]->name . ')';
}

no Moose;
__PACKAGE__->meta->make_immutable;

1;
