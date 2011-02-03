package Gapp::Meta::Attribute::Trait::GtkMenu;
use Moose::Role;

use MooseX::Types::Moose qw( Str );


before '_process_options' => sub {
    my $class   = shift;
    my $name    = shift;
    my $options = shift;
    
    $options->{class} = 'Gtk2::Menu' if ! exists $options->{class};
};


package Moose::Meta::Attribute::Custom::Trait::GtkMenu;
sub register_implementation { 'Gapp::Meta::Attribute::Trait::GtkMenu' };

1;
