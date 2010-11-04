package Gapp::Meta::Attribute::Trait::GtkToolbar;
use Moose::Role;

use MooseX::Types::Moose qw( Str );

has 'style' => (
    is => 'rw',
    isa => Str,
);

has 'icon_size' => (
    is => 'rw',
    isa => Str,
);


before '_process_options' => sub {
    my $class   = shift;
    my $name    = shift;
    my $options = shift;
    
    $options->{class} = 'Gtk2::Toolbar' if ! exists $options->{class};
    
    unshift @{ $options->{build} }, sub {
        my ( $self, $w ) = @_;
        $w->set_style( $options->{style} ) if exists $options->{style};
        $w->set_icon_size( $options->{icon_size} ) if exists $options->{icon_size}
    };
};


package Moose::Meta::Attribute::Custom::Trait::GtkToolbar;
sub register_implementation { 'Gapp::Meta::Attribute::Trait::GtkToolbar' };

1;
