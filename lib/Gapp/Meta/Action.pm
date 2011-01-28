package Gapp::Meta::Action;

use Moose;
use MooseX::SemiAffordanceAccessor;
use MooseX::StrictConstructor;
use MooseX::Method::Signatures;

use MooseX::Types::Moose qw( CodeRef HashRef Object Str  );

has [qw( label name)] => (
    is => 'rw',
    isa => Str,
    default => '',
);

has 'tooltip' => (
    is => 'rw',
    isa => Str,
    clearer => 'clear_tooltip',
    predicate => 'has_tooltip',
);

has 'icon' => (
    is => 'rw',
    isa => Str,
    clearer => 'clear_icon',
    predicate => 'has_icon',
);

has 'code' => (
    is => 'rw',
    isa => CodeRef,
    clearer => 'clear_code',
    predicate => 'has_code',
);


method perform ( @args ) {
    &{$self->code}( $self, @args ) if $self->has_code;
}

no Moose;
__PACKAGE__->meta->make_immutable;

1;
