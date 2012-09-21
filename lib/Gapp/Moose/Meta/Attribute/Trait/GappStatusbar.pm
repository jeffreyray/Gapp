package Gapp::Moose::Meta::Attribute::Trait::GappStatusbar;
use Moose::Role;

before '_process_options' => sub {
    my ( $class, $name, $opts ) = @_;
    $opts->{gclass} = 'Gapp::Statusbar' if ! exists $opts->{class};
};

package Moose::Meta::Attribute::Custom::Trait::GappStatusbar;
sub register_implementation { 'Gapp::Moose::Meta::Attribute::Trait::GappStatusbar' };
1;
