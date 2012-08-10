package Gapp::Moose::Meta::Attribute::Trait::GappHPaned;
use Moose::Role;

before '_process_options' => sub {
    my ( $class, $name, $opts ) = @_;
    $opts->{class} = 'Gapp::HPaned' if ! exists $opts->{class};
};

package Moose::Meta::Attribute::Custom::Trait::GappHPaned;
sub register_implementation { 'Gapp::Moose::Meta::Attribute::Trait::GappHPaned' };
1;
