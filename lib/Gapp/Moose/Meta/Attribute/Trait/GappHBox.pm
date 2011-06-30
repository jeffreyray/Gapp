package Gapp::Moose::Meta::Attribute::Trait::GappHBox;
use Moose::Role;

before '_process_options' => sub {
    my ( $class, $name, $opts ) = @_;
    $opts->{class} = 'Gapp::HBox' if ! exists $opts->{class};
};

package Moose::Meta::Attribute::Custom::Trait::GappHBox;
sub register_implementation { 'Gapp::Moose::Meta::Attribute::Trait::GappHBox' };
1;
