package Gapp::Moose::Meta::Attribute::Trait::GappScrolledWindow;
use Moose::Role;

before '_process_options' => sub {
    my ( $class, $name, $opts ) = @_;
    $opts->{class} = 'Gapp::ScrolledWindow' if ! exists $opts->{class};
};

package Moose::Meta::Attribute::Custom::Trait::GappScrolledWindow;
sub register_implementation { 'Gapp::Moose::Meta::Attribute::Trait::GappScrolledWindow' };
1;
