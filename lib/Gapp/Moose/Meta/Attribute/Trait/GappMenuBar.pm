package Gapp::Moose::Meta::Attribute::Trait::GappMenuBar;
use Moose::Role;

before '_process_options' => sub {
    my ( $class, $name, $opts ) = @_;
    $opts->{class} = 'Gapp::MenuBar' if ! exists $opts->{class};
};

package Moose::Meta::Attribute::Custom::Trait::GappMenuBar;
sub register_implementation { 'Gapp::Moose::Meta::Attribute::Trait::GappMenuBar' };
1;
