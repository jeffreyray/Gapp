package Gapp::Meta::Attribute::Trait::GtkWindow;
use Moose::Role;

use MooseX::Types::Moose qw( Str );

has 'icon' => (
    is => 'rw',
    isa => Str,
);


before '_process_options' => sub {
    my $class   = shift;
    my $name    = shift;
    my $options = shift;
    
    $options->{class} = 'Gtk2::Window' if ! exists $options->{class};
    
    unshift @{ $options->{build} }, sub {
        my ( $self, $w ) = @_;
        $w->set_icon( $w->render_icon( $options->{icon}, 'dnd' ) ) if exists $options->{icon};
    };
};


package Moose::Meta::Attribute::Custom::Trait::GtkWindow;
sub register_implementation { 'Gapp::Meta::Attribute::Trait::GtkWindow' };

1;
