package Gapp::Moose::Meta::Attribute::Trait::ImageMenuItem;
use Moose::Role;

before '_process_options' => sub {
    my ( $class, $name, $opts ) = @_;
    $opts->{gclass} = 'Gapp::ImageMenuItem' if ! exists $opts->{class};
};

package Moose::Meta::Attribute::Custom::Trait::GappImageMenuItem;
sub register_implementation { 'Gapp::Moose::Meta::Attribute::Trait::GappImageMenuItem' };
1;
