package Gapp::Moose::Meta::Attribute::Trait::GappUIManager;
use Moose::Role;

before '_process_options' => sub {
    my ( $class, $name, $opts ) = @_;
    $opts->{gclass} = 'Gapp::UIManager' if ! exists $opts->{class};
};

package Moose::Meta::Attribute::Custom::Trait::GappUIManager;
sub register_implementation { 'Gapp::Moose::Meta::Attribute::Trait::GappUIManager' };
1;
