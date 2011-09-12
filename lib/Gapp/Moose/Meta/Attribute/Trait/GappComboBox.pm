package Gapp::Moose::Meta::Attribute::Trait::GappComboBox;
use Moose::Role;

before '_process_options' => sub {
    my ( $class, $name, $opts ) = @_;
    $opts->{class} = 'Gapp::ComboBox' if ! exists $opts->{class};
};

package Moose::Meta::Attribute::Custom::Trait::GappComboBox;
sub register_implementation { 'Gapp::Moose::Meta::Attribute::Trait::GappComboBox' };
1;
