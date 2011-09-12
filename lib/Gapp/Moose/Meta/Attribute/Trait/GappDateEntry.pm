package Gapp::Moose::Meta::Attribute::Trait::GappDateEntry;
use Moose::Role;

before '_process_options' => sub {
    my ( $class, $name, $opts ) = @_;
    $opts->{class} = 'Gapp::DateEntry' if ! exists $opts->{class};
};

package Moose::Meta::Attribute::Custom::Trait::GappDateEntry;
sub register_implementation { 'Gapp::Moose::Meta::Attribute::Trait::GappDateEntry' };
1;
