package Gapp::Moose::Meta::Attribute::Trait::GappToolButton;
use Moose::Role;

before '_process_options' => sub {
    my ( $class, $name, $opts ) = @_;
    $opts->{gclass} = 'Gapp::ToolButton' if ! exists $opts->{class};
};

package Moose::Meta::Attribute::Custom::Trait::GappToolButton;
sub register_implementation { 'Gapp::Moose::Meta::Attribute::Trait::GappToolButton' };
1;
