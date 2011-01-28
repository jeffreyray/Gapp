package Gapp::Meta::Attribute::Trait::GtkUIManager;
use Moose::Role;

use Gapp::Actions::Util;
use MooseX::Types::Moose qw( ArrayRef ClassName CodeRef HashRef Object Str );



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
            
            for my $action ( @{ $options->{actions} } ) {
                
                if ( is_Object( $action ) ) {
                    my $gtk_action = Gtk2::Action->new( 
                        name => $action->name,
                        label => $action->label,
                        tooltip => $action->tooltip,
                        $action->icon ? ( 'stock-id' => $action->icon ) : (),
                    );
                    $group->add_action( $gtk_action );
                    $gtk_action->signal_connect( activate => sub {
                        my ( $w, @args ) = @_;
                        $action->perform( $self, $w, @args );
                    });
                }
                elsif ( is_ClassName( $action ) ) {
                    for my $action ( ACTION_REGISTRY( $action )->actions ) {
                        my $gtk_action = Gtk2::Action->new( 
                            name => $action->name,
                            label => $action->label,
                            tooltip => $action->tooltip,
                            'stock-id' => $action->icon,
                        );
                        $group->add_action( $gtk_action );
                        $gtk_action->signal_connect( activate => sub {
                            my ( $w, @args ) = @_;
                            $action->perform( $self, $w, @args );
                        });
                    }
                }
    
                #$gtk_action->signal_connect( activate => sub {
                #    my ( $w, @args ) = @_;
                #    $action->perform( $self, $w, @args );
                #});
                
                #elsif ( is_ArrayRef( $action ) ) {
                #    my ( $action_name, $label, $tooltip, $stockid, $delegate ) = ( @$action );
                #    $gtk_action = Gtk2::Action->new( 
                #        name => $action_name,
                #        label => $label,
                #        tooltip => $tooltip,
                #        'stock-id' => $stockid,
                #    );
                #}
                #

                
            }
            
            $ui->insert_action_group( $group, 0 );
        }    
    };
};


package Moose::Meta::Attribute::Custom::Trait::GtkUIManager;
sub register_implementation { 'Gapp::Meta::Attribute::Trait::GtkUIManager' };

1;
