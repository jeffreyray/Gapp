package Gapp::Meta::Attribute::Trait::GtkButton;
use Moose::Role;

use MooseX::Types::Moose qw( Str );

has 'image' => (
    is => 'rw',
    isa => Str,
);

has 'label' => (
    is => 'rw',
    isa => Str,
);


before '_process_options' => sub {
    my $class   = shift;
    my $name    = shift;
    my $options = shift;
    
    $options->{class} = 'Gtk2::Button' if ! exists $options->{class};
    unshift @{ $options->{build} }, sub {
        my ( $self, $w ) = @_;
        if ( $options->{image} ) {
            my $image = Gtk2::Image->new_from_stock( $options->{image}, 'button' );
            $w->set_image( $image );
            $w->set_label( $options->{label} ) if exists $options->{label};
        }
    };
};


package Moose::Meta::Attribute::Custom::Trait::GtkButton;
sub register_implementation { 'Gapp::Meta::Attribute::Trait::GtkButton' };

1;
