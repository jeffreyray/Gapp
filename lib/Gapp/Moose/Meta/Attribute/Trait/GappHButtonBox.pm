package Gapp::Moose::Meta::Attribute::Trait::GappHButtonBox;
use Moose::Role;

before '_process_options' => sub {
    my ( $class, $name, $opts ) = @_;
    $opts->{class} = 'Gapp::HButtonBox' if ! exists $opts->{class};
};

package Moose::Meta::Attribute::Custom::Trait::GappHButtonBox;
sub register_implementation { 'Gapp::Moose::Meta::Attribute::Trait::GappHButtonBox' };
1;
