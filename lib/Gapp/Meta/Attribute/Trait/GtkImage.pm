package Gapp::Meta::Attribute::Trait::GtkImage;
use Moose::Role;

use MooseX::Types::Moose qw( ArrayRef Str );

has 'file' => (
    is => 'rw',
    isa => Str,
);

has 'stock' => (
    is => 'rw',
    isa => ArrayRef,
);


before '_process_options' => sub {
    my $class   = shift;
    my $name    = shift;
    my $options = shift;
    
    $options->{class} = 'Gtk2::Image' if ! exists $options->{class};
    
    unshift @{ $options->{build} }, sub {
        my ( $self, $w ) = @_;
        $w->set_from_stock( @{ $options->{stock} } ) if exists $options->{stock};
        $w->set_from_file( $options->{file} ) if exists $options->{file};
    };
};


package Moose::Meta::Attribute::Custom::Trait::GtkImage;
sub register_implementation { 'Gapp::Meta::Attribute::Trait::GtkImage' };

1;
