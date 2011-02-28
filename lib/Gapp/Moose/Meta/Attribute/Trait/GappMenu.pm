package Gapp::Moose::Meta::Attribute::Trait::GappMenu;
use Moose::Role;

before '_process_options' => sub {
    my ( $class, $name, $opts ) = @_;
    $opts->{class} = 'Gapp::Menu' if ! exists $opts->{class};
};

package Moose::Meta::Attribute::Custom::Trait::GappMenu;
sub register_implementation { 'Gapp::Moose::Meta::Attribute::Trait::GappMenu' };
1;
