package Gapp::Meta::Attribute::Trait::GtkActionGroup;
use Moose::Role;

use MooseX::Types::Moose qw( ArrayRef CodeRef HashRef Str );

has 'actions' => (
    is => 'rw',
    isa => ArrayRef,
    default => sub { [ ] },
);

has 'method_prefix' => (
    is => 'rw',
    isa => Str,
    default => '_do_action_',
);

before '_process_options' => sub {
    my $class   = shift;
    my $name    = shift;
    my $options = shift;
    
    $options->{class} = 'Gtk2::ActionGroup' if ! exists $options->{class};
    $options->{args} = [ $name ] if ! exists $options->{args};
    
    # if actions were specified, then we add a CodeRef to the 'build' option
    # which creates the actions when the action group is created 

    unshift @{ $options->{build} }, sub {
        
        my ( $self, $w ) = @_;
        
        if ( $options->{actions} ) {
        
            for ( @{ $options->{actions} } ) {
                
                my ( $action_name, $label, $tooltip, $stockid, $delegate ) = ( @$_ );
                
                my $action = Gtk2::Action->new( 
                    name => $action_name,
                    label => $label,
                    tooltip => $tooltip,
                    'stock-id' => $stockid,
                );
                
                my $att = $self->meta->get_attribute( $name );
                my $method = $att->method_prefix . $action_name;
                
                defined $delegate ?
                $action->signal_connect( activate => sub { $self->$delegate->$method } ):
                $action->signal_connect( activate => sub { $self->$method } );
                
                
                $w->add_action( $action );
            }
        }    
    };

};


package Moose::Meta::Attribute::Custom::Trait::GtkActionGroup;
sub register_implementation { 'Gapp::Meta::Attribute::Trait::GtkActionGroup' };

1;
