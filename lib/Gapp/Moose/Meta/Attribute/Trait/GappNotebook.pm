package Gapp::Moose::Meta::Attribute::Trait::GappNotebook;
use Moose::Role;

before '_process_options' => sub {
    my ( $class, $name, $opts ) = @_;
    $opts->{gclass} = 'Gapp::Notebook' if ! exists $opts->{class};
};

package Moose::Meta::Attribute::Custom::Trait::GappNotebook;
sub register_implementation { 'Gapp::Moose::Meta::Attribute::Trait::GappNotebook' };
1;
