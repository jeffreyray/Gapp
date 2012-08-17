package Gapp::Moose::Meta::Attribute::Trait::GappButton;
use Moose::Role;

before '_process_options' => sub {
    my ( $class, $name, $opts ) = @_;
    $opts->{gclass} = 'Gapp::Button' if ! exists $opts->{class};
};

package Moose::Meta::Attribute::Custom::Trait::GappButton;
sub register_implementation { 'Gapp::Moose::Meta::Attribute::Trait::GappButton' };
1;
