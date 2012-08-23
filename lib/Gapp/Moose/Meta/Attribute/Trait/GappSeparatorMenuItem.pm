package Gapp::Moose::Meta::Attribute::Trait::SeparatorMenuItem;
use Moose::Role;

before '_process_options' => sub {
    my ( $class, $name, $opts ) = @_;
    $opts->{gclass} = 'Gapp::SeparatorMenuItem' if ! exists $opts->{class};
};

package Moose::Meta::Attribute::Custom::Trait::GappSeparatorMenuItem;
sub register_implementation { 'Gapp::Moose::Meta::Attribute::Trait::GappSeparatorMenuItem' };
1;
