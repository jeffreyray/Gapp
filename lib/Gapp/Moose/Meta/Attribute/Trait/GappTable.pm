package Gapp::Moose::Meta::Attribute::Trait::GappTable;
use Moose::Role;

before '_process_options' => sub {
    my ( $class, $name, $opts ) = @_;
    $opts->{gclass} = 'Gapp::Table' if ! exists $opts->{class};
};

package Moose::Meta::Attribute::Custom::Trait::GappTable;
sub register_implementation { 'Gapp::Moose::Meta::Attribute::Trait::GappTable' };
1;
