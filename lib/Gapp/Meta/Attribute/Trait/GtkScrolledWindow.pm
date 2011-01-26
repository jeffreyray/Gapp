package Gapp::Meta::Attribute::Trait::GtkScrolledWindow;
use Moose::Role;

use MooseX::Types::Moose qw( ArrayRef Undef );

has 'policy' => (
    is => 'rw',
    isa => ArrayRef|Undef,
);

before '_process_options' => sub {
    my $class   = shift;
    my $name    = shift;
    my $options = shift;
    
    $options->{class} = 'Gtk2::ScrolledWindow' if ! exists $options->{class};
    
    unshift @{ $options->{build} }, sub {
        my ( $self, $w ) = @_;
        $w->set_policy( @{ $options->{policy} } ) if $options->{policy};
    };
};


package Moose::Meta::Attribute::Custom::Trait::GtkScrolledWindow;
sub register_implementation { 'Gapp::Meta::Attribute::Trait::GtkScrolledWindow' };

1;
