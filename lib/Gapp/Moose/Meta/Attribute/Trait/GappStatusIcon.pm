package Gapp::Moose::Meta::Attribute::Trait::GappStatusIcon;
use Moose::Role;

use MooseX::Types::Moose qw( Str );

before '_process_options' => sub {
    my ( $class, $name, $opts ) = @_;
    $opts->{class} = 'Gapp::StatusIcon' if ! exists $opts->{class};
};


package Moose::Meta::Attribute::Custom::Trait::GappStatusIcon;
sub register_implementation { 'Gapp::Meta::Attribute::Trait::GappStatusIcon' };

1;
