package Gapp::Moose::Meta::Attribute::Trait::CheckMenuItem;
use Moose::Role;

before '_process_options' => sub {
    my ( $class, $name, $opts ) = @_;
    $opts->{gclass} = 'Gapp::CheckMenuItem' if ! exists $opts->{class};
};

package Moose::Meta::Attribute::Custom::Trait::CheckMenuItem;
sub register_implementation { 'Gapp::Moose::Meta::Attribute::Trait::GappCheckMenuItem' };
1;
