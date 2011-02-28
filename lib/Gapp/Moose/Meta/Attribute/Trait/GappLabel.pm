package Gapp::Moose::Meta::Attribute::Trait::GappLabel;
use Moose::Role;

before '_process_options' => sub {
    my ( $class, $name, $opts ) = @_;
    $opts->{class} = 'Gapp::Label' if ! exists $opts->{class};
};

package Moose::Meta::Attribute::Custom::Trait::GappLabel;
sub register_implementation { 'Gapp::Moose::Meta::Attribute::Trait::GappLabel' };
1;
