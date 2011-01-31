package Gapp::Meta::Attribute::Trait::GtkListStore;
use Moose::Role;

use MooseX::Types::Moose qw( ArrayRef Str );

has 'columns' => (
    is => 'ro',
    isa => ArrayRef,
    default => sub { [ ] },
);


before '_process_options' => sub {
    my $class   = shift;
    my $name    = shift;
    my $options = shift;
    
    
    $options->{class} = 'Gtk2::ListStore' if ! exists $options->{class};
    $options->{args} = [ @{ $options->{columns} } ] if ! exists $options->{args};
};


package Moose::Meta::Attribute::Custom::Trait::GtkListStore;
sub register_implementation { 'Gapp::Meta::Attribute::Trait::GtkListStore' };

1;
