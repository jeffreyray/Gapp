package Gapp::Moose::Meta::Attribute::Trait::GappExpander;
use Moose::Role;

before '_process_options' => sub {
    my ( $class, $name, $opts ) = @_;
    $opts->{gclass} = 'Gapp::Expander' if ! exists $opts->{class};
};

package Moose::Meta::Attribute::Custom::Trait::GappExpander;
sub register_implementation { 'Gapp::Moose::Meta::Attribute::Trait::GappExpander' };
1;
