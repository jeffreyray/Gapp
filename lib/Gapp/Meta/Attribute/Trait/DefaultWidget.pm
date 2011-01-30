package Gapp::Meta::Attribute::Trait::DefaultWidget;
use Moose::Role;

before '_process_options' => sub {
    my $class   = shift;
    my $name    = shift;
    my $options = shift;

    $options->{handles} = [qw/hide show show_all/],
};


package Moose::Meta::Attribute::Custom::Trait::DefaultWidget;
sub register_implementation { 'Gapp::Meta::Attribute::Trait::DefaultWidget' };

1;
