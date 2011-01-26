package Gapp::Meta::Attribute::Trait::GtkStatusIcon;
use Moose::Role;

use MooseX::Types::Moose qw( Str );


has 'icon' => (
    is => 'rw',
    isa => Str,
);

has 'tooltip' => (
    is => 'rw',
    isa => Str,
);

before '_process_options' => sub {
    my $class   = shift;
    my $name    = shift;
    my $options = shift;
    
    $options->{class} = 'Gtk2::StatusIcon' if ! exists $options->{class};

    unshift @{ $options->{build} }, sub {
        my ( $self, $w ) = @_;
        $w->set_tooltip( $options->{tooltip} ) if exists $options->{tooltip};
        $w->set_from_stock( $options->{icon} ) if exists $options->{icon};
    };
};


package Moose::Meta::Attribute::Custom::Trait::GtkStatusIcon;
sub register_implementation { 'Gapp::Meta::Attribute::Trait::GtkStatusIcon' };

1;
