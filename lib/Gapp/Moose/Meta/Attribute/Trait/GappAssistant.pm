package Gapp::Moose::Meta::Attribute::Trait::GappAssistant;
use Moose::Role;

use MooseX::Types::Moose qw( Str );

before '_process_options' => sub {
    my ( $class, $name, $opts ) = @_;
    $opts->{class} = 'Gapp::Assistant' if ! exists $opts->{class};
};


package Moose::Meta::Attribute::Custom::Trait::GappAssistant;
sub register_implementation { 'Gapp::Meta::Attribute::Trait::GappAssistant' };

1;
