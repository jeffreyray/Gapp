package Gapp::Moose::Meta::Attribute::Trait::GappFileChooserDialog;
use Moose::Role;

before '_process_options' => sub {
    my ( $class, $name, $opts ) = @_;
    $opts->{class} = 'Gapp::FileChooserDialog' if ! exists $opts->{class};
};

package Moose::Meta::Attribute::Custom::Trait::GappFileChooserDialog;
sub register_implementation { 'Gapp::Moose::Meta::Attribute::Trait::GappFileChooserDialog' };
1;
