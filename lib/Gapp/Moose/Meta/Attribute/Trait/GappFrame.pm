package Gapp::Moose::Meta::Attribute::Trait::GappFrame;
use Moose::Role;

before '_process_options' => sub {
    my ( $class, $name, $opts ) = @_;
    $opts->{gclass} = 'Gapp::Frame' if ! exists $opts->{class};
};

package Moose::Meta::Attribute::Custom::Trait::GappFrame;
sub register_implementation { 'Gapp::Moose::Meta::Attribute::Trait::GappFrame' };
1;
