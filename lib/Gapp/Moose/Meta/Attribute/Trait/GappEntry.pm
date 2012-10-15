package Gapp::Moose::Meta::Attribute::Trait::GappEntry;
use Moose::Role;

before '_process_options' => sub {
    my ( $class, $name, $opts ) = @_;
    $opts->{gclass} = 'Gapp::Entry' if ! exists $opts->{class};
};

package Moose::Meta::Attribute::Custom::Trait::GappEntry;
sub register_implementation { 'Gapp::Moose::Meta::Attribute::Trait::GappEntry' };
1;
