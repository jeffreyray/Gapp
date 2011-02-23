package Gapp::Moose::Meta::Attribute::Trait::GappButton;
use Moose::Role;

use MooseX::Types::Moose qw( Str );

before '_process_options' => sub {
    my ( $class, $name, $opts ) = @_;
    $opts->{class} = 'Gapp::Button' if ! exists $opts->{class};
};


package Moose::Meta::Attribute::Custom::Trait::GappButton;
sub register_implementation { 'Gapp::Meta::Attribute::Trait::GappButton' };

1;
