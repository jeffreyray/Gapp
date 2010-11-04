package Gapp::Meta::Attribute::Trait::GtkTextView;
use Moose::Role;

use MooseX::Types::Moose qw( Str );

before '_process_options' => sub {
    my $class   = shift;
    my $name    = shift;
    my $options = shift;
    
    $options->{class} = 'Gtk2::TextView' if ! exists $options->{class};
};


package Moose::Meta::Attribute::Custom::Trait::GtkTextView;
sub register_implementation { 'Gapp::Meta::Attribute::Trait::GtkTextView' };

1;
