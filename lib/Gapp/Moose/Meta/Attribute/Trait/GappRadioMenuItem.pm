package Gapp::Moose::Meta::Attribute::Trait::RadioMenuItem;
use Moose::Role;

before '_process_options' => sub {
    my ( $class, $name, $opts ) = @_;
    $opts->{gclass} = 'Gapp::RadioMenuItem' if ! exists $opts->{class};
};

package Moose::Meta::Attribute::Custom::Trait::RadioMenuItem;
sub register_implementation { 'Gapp::Moose::Meta::Attribute::Trait::GappRadioMenuItem' };
1;
