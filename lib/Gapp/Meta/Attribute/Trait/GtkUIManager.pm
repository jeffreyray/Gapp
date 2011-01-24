package Gapp::Meta::Attribute::Trait::GtkUIManager;
use Moose::Role;

use MooseX::Types::Moose qw( ArrayRef CodeRef HashRef Str );

has 'files' => (
    is => 'rw',
    isa => ArrayRef,
    default => sub { [ ] },
);

has 'actions' => (
    is =>  'rw',
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
    
    $options->{class} = 'Gtk2::UIManager' if ! exists $options->{class};
    
    # if actions were specified, then we add a CodeRef to the 'build' option
    # which creates the actions when the action group is created 
    unshift @{ $options->{build} }, sub {
        my ( $self, $w ) = @_;
        $w->add_ui_from_file( $_ ) for @{ $options->{files} };
    };
    
    # if actions were specified, then we add a CodeRef to the 'build' option
    # which creates the actions when the action group is created 
    unshift @{ $options->{build} }, sub {
        
        my ( $self, $ui ) = @_;
        
        # This code is copied from GtkActionGroup, should possibly reuse
        if ( $options->{actions} ) {
            
            my $group = Gtk2::ActionGroup->new( $name );
            
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
                
                
                $group->add_action( $action );
            }
            
            $ui->insert_action_group( $group, 0 );
        }    
    };
};


package Moose::Meta::Attribute::Custom::Trait::GtkUIManager;
sub register_implementation { 'Gapp::Meta::Attribute::Trait::GtkUIManager' };

1;
