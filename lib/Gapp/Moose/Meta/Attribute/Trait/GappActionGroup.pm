package Gapp::Moose::Meta::Attribute::Trait::GappActionGroup;
use Moose::Role;

before '_process_options' => sub {
    my ( $class, $name, $opts ) = @_;
    $opts->{class} = 'Gapp::ActionGroup' if ! exists $opts->{class};
};

package Moose::Meta::Attribute::Custom::Trait::GappActionGroup;
sub register_implementation { 'Gapp::Moose::Meta::Attribute::Trait::GappActionGroup' };
1;
