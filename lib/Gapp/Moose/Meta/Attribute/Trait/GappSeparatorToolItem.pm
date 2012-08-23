package Gapp::Moose::Meta::Attribute::Trait::SeparatorToolItem;
use Moose::Role;

before '_process_options' => sub {
    my ( $class, $name, $opts ) = @_;
    $opts->{gclass} = 'Gapp::SeparatorToolItem' if ! exists $opts->{class};
};

package Moose::Meta::Attribute::Custom::Trait::GappSeparatorToolItem;
sub register_implementation { 'Gapp::Moose::Meta::Attribute::Trait::GappSeparatorToolItem' };
1;
