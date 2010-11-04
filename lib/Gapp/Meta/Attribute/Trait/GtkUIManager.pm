package Gapp::Meta::Attribute::Trait::GtkUIManager;
use Moose::Role;

use MooseX::Types::Moose qw( ArrayRef CodeRef HashRef Str );

has 'files' => (
    is => 'rw',
    isa => ArrayRef,
    default => sub { [ ] },
);


before '_process_options' => sub {
    my $class   = shift;
    my $name    = shift;
    my $options = shift;
    
    $options->{class} = 'Gtk2::UIManager' if ! exists $options->{class};
    
    # if actions were specified, then we add a CodeRef to the 'build' option
    # which creates the actions when the action group is created 
    unshift @{ $options->{build} }, sub {
        my ( $self, $w ) = @_;
        $w->add_ui_from_file( $_ ) for @{ $options->{files} };
    };   
};


package Moose::Meta::Attribute::Custom::Trait::GtkUIManager;
sub register_implementation { 'Gapp::Meta::Attribute::Trait::GtkUIManager' };

1;
