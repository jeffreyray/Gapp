package Gapp::Moose::Meta::Attribute::Trait::GappBox;
use Moose::Role;

before '_process_options' => sub {
    my ( $class, $name, $opts ) = @_;
    $opts->{class} = 'Gapp::Box' if ! exists $opts->{class};
};

package Moose::Meta::Attribute::Custom::Trait::GappBox;
sub register_implementation { 'Gapp::Moose::Meta::Attribute::Trait::GappBox' };
1;
