package Gapp::Moose::Meta::Attribute::Trait::GappDialog;
use Moose::Role;

before '_process_options' => sub {
    my ( $class, $name, $opts ) = @_;
    $opts->{class} = 'Gapp::Dialog' if ! exists $opts->{class};
};

package Moose::Meta::Attribute::Custom::Trait::GappDialog;
sub register_implementation { 'Gapp::Moose::Meta::Attribute::Trait::GappDialog' };
1;
