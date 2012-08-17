package Gapp::Moose::Meta::Attribute::Trait::GappToolPalette;
use Moose::Role;

before '_process_options' => sub {
    my ( $class, $name, $opts ) = @_;
    $opts->{gclass} = 'Gapp::ToolPalette' if ! exists $opts->{class};
};

package Moose::Meta::Attribute::Custom::Trait::GappToolPalette;
sub register_implementation { 'Gapp::Moose::Meta::Attribute::Trait::GappToolPalette' };
1;
