package Gapp::Moose::Meta::Attribute::Trait::GappTextBuffer;
use Moose::Role;

before '_process_options' => sub {
    my ( $class, $name, $opts ) = @_;
    $opts->{gclass} = 'Gapp::TextBuffer' if ! exists $opts->{class};
};

package Moose::Meta::Attribute::Custom::Trait::GappTextBuffer;
sub register_implementation { 'Gapp::Moose::Meta::Attribute::Trait::GappTextBuffer' };
1;
