package Gapp::Moose::Meta::Attribute::Trait::GappToolItemGroup;
use Moose::Role;

before '_process_options' => sub {
    my ( $class, $name, $opts ) = @_;
    $opts->{class} = 'Gapp::ToolItemGroup' if ! exists $opts->{class};
};

package Moose::Meta::Attribute::Custom::Trait::GappToolItemGroup;
sub register_implementation { 'Gapp::Moose::Meta::Attribute::Trait::GappToolItemGroup' };
1;
