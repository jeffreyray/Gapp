package Gapp::Moose::Meta::Attribute::Trait::GappMenuToolButton;
use Moose::Role;

before '_process_options' => sub {
    my ( $class, $name, $opts ) = @_;
    $opts->{gclass} = 'Gapp::MenuToolButton' if ! exists $opts->{class};
};

package Moose::Meta::Attribute::Custom::Trait::GappMenuToolButton;
sub register_implementation { 'Gapp::Moose::Meta::Attribute::Trait::GappMenuToolButton' };
1;
