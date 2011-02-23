package Gapp::Moose::Meta::Attribute::Trait::GappToolbar;
use Moose::Role;

use MooseX::Types::Moose qw( Str );

before '_process_options' => sub {
    my ( $class, $name, $opts ) = @_;
    $opts->{class} = 'Gapp::Toolbar' if ! exists $opts->{class};
};


package Moose::Meta::Attribute::Custom::Trait::GappToolbar;
sub register_implementation { 'Gapp::Meta::Attribute::Trait::GappToolbar' };

1;
