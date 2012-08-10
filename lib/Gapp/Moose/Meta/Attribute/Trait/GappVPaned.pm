package Gapp::Moose::Meta::Attribute::Trait::GappVPaned;
use Moose::Role;

before '_process_options' => sub {
    my ( $class, $name, $opts ) = @_;
    $opts->{class} = 'Gapp::VPaned' if ! exists $opts->{class};
};

package Moose::Meta::Attribute::Custom::Trait::GappVPaned;
sub register_implementation { 'Gapp::Moose::Meta::Attribute::Trait::GappVPaned' };
1;
