package Gapp::Moose::Meta::Attribute::Trait::GappViewport;
use Moose::Role;

before '_process_options' => sub {
    my ( $class, $name, $opts ) = @_;
    $opts->{gclass} = 'Gapp::Viewport' if ! exists $opts->{class};
};

package Moose::Meta::Attribute::Custom::Trait::GappViewport;
sub register_implementation { 'Gapp::Moose::Meta::Attribute::Trait::GappViewport' };
1;
