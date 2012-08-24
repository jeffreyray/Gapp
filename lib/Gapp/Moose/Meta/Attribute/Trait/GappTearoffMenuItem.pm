package Gapp::Moose::Meta::Attribute::Trait::TearoffMenuItem;
use Moose::Role;

before '_process_options' => sub {
    my ( $class, $name, $opts ) = @_;
    $opts->{gclass} = 'Gapp::TearoffMenuItem' if ! exists $opts->{class};
};

package Moose::Meta::Attribute::Custom::Trait::GappTearoffMenuItem;
sub register_implementation { 'Gapp::Moose::Meta::Attribute::Trait::GappTearoffMenuItem' };
1;
