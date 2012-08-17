package Gapp::Moose::Meta::Attribute::Trait::GappWindow;
use Moose::Role;

before '_process_options' => sub {
    my ( $class, $name, $opts ) = @_;
    $opts->{gclass} = 'Gapp::Window' if ! exists $opts->{class};
};

package Moose::Meta::Attribute::Custom::Trait::GappWindow;
sub register_implementation { 'Gapp::Moose::Meta::Attribute::Trait::GappWindow' };
1;
