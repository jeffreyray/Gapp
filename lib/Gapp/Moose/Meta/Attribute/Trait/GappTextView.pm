package Gapp::Moose::Meta::Attribute::Trait::GappTextView;
use Moose::Role;

before '_process_options' => sub {
    my ( $class, $name, $opts ) = @_;
    $opts->{class} = 'Gapp::TextView' if ! exists $opts->{class};
};

package Moose::Meta::Attribute::Custom::Trait::GappTextView;
sub register_implementation { 'Gapp::Moose::Meta::Attribute::Trait::GappTextView' };
1;
