package Gapp::Moose::Meta::Attribute::Trait::GappEventBox;
use Moose::Role;

before '_process_options' => sub {
    my ( $class, $name, $opts ) = @_;
    $opts->{gclass} = 'Gapp::EventBox' if ! exists $opts->{class};
};

package Moose::Meta::Attribute::Custom::Trait::GappEventBox;
sub register_implementation { 'Gapp::Moose::Meta::Attribute::Trait::GappEventBox' };
1;
