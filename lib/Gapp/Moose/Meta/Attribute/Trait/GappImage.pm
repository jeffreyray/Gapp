package Gapp::Moose::Meta::Attribute::Trait::GappImage;
use Moose::Role;

before '_process_options' => sub {
    my ( $class, $name, $opts ) = @_;
    $opts->{class} = 'Gapp::Image' if ! exists $opts->{class};
};

package Moose::Meta::Attribute::Custom::Trait::GappImage;
sub register_implementation { 'Gapp::Moose::Meta::Attribute::Trait::GappImage' };
1;
