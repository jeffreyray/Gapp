package Gapp::Moose::Meta::Attribute::Trait::GappUIManager;
use Moose::Role;

use MooseX::Types::Moose qw( Str );

before '_process_options' => sub {
    my ( $class, $name, $opts ) = @_;
    $opts->{class} = 'Gapp::UIManager' if ! exists $opts->{class};
};


package Moose::Meta::Attribute::Custom::Trait::GappUIManager;
sub register_implementation { 'Gapp::Meta::Attribute::Trait::GappUIManager' };

1;
