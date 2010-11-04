package Gapp::Meta::Attribute::Trait::GtkLabel;
use Moose::Role;

use MooseX::Types::Moose qw( Str );

has 'icon' => (
    is => 'rw',
    isa => Str,
);

has 'text' => (
    is => 'rw',
    isa => Str,
);


before '_process_options' => sub {
    my $class   = shift;
    my $name    = shift;
    my $options = shift;
    
    $options->{class} = 'Gtk2::Label' if ! exists $options->{class};
    $options->{args} = [ $options->{text} ] if ! exists $options->{args};
};


package Moose::Meta::Attribute::Custom::Trait::GtkLabel;
sub register_implementation { 'Gapp::Meta::Attribute::Trait::GtkLabel' };

1;
