package Gapp::Meta::Attribute::Trait::GappDefault;
use Moose::Role;

before '_process_options' => sub {
    my $class   = shift;
    my $name    = shift;
    my $options = shift;

    $options->{handles} = [qw(
        destroy
        hide
        show
        show_all
        signal_connect
        signal_emit
    )],
};


package Moose::Meta::Attribute::Custom::Trait::GappDefault;
sub register_implementation { 'Gapp::Meta::Attribute::Trait::GappDefault' };

1;
