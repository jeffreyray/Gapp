package Gapp::Moose::Meta::Attribute::Trait::GappStatusIcon;
use Moose::Role;

before '_process_options' => sub {
    my ( $class, $name, $opts ) = @_;
    $opts->{gclass} = 'Gapp::StatusIcon' if ! exists $opts->{class};
};

package Moose::Meta::Attribute::Custom::Trait::GappStatusIcon;
sub register_implementation { 'Gapp::Moose::Meta::Attribute::Trait::GappStatusIcon' };
1;
