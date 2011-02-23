package Gapp::Moose::Meta::Attribute::Trait::GappListStore;
use Moose::Role;

use MooseX::Types::Moose qw( Str );

before '_process_options' => sub {
    my ( $class, $name, $opts ) = @_;
    $opts->{class} = 'Gapp::ListStore' if ! exists $opts->{class};
};


package Moose::Meta::Attribute::Custom::Trait::GappListStore;
sub register_implementation { 'Gapp::Meta::Attribute::Trait::GappListStore' };

1;
