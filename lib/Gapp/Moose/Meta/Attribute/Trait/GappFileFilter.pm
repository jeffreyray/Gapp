package Gapp::Moose::Meta::Attribute::Trait::GappFileFilter;
use Moose::Role;

before '_process_options' => sub {
    my ( $class, $name, $opts ) = @_;
    $opts->{class} = 'Gapp::FileFilter' if ! exists $opts->{class};
};

package Moose::Meta::Attribute::Custom::Trait::GappFileFilter;
sub register_implementation { 'Gapp::Moose::Meta::Attribute::Trait::GappFileFilter' };
1;
