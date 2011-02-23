package Gapp::Moose::Meta::Attribute::Trait::GappLabel;
use Moose::Role;

use MooseX::Types::Moose qw( Str );

before '_process_options' => sub {
    my ( $class, $name, $opts ) = @_;
    $opts->{class} = 'Gapp::Label' if ! exists $opts->{class};
};


package Moose::Meta::Attribute::Custom::Trait::GappLabel;
sub register_implementation { 'Gapp::Meta::Attribute::Trait::GappLabel' };

1;
