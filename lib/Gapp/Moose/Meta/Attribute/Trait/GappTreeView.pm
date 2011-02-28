package Gapp::Moose::Meta::Attribute::Trait::GappTreeView;
use Moose::Role;

before '_process_options' => sub {
    my ( $class, $name, $opts ) = @_;
    $opts->{class} = 'Gapp::TreeView' if ! exists $opts->{class};
};

package Moose::Meta::Attribute::Custom::Trait::GappTreeView;
sub register_implementation { 'Gapp::Moose::Meta::Attribute::Trait::GappTreeView' };
1;
