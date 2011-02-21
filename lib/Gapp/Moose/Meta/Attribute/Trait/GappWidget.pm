package Gapp::Meta::Attribute::Trait::GappWidget;
use Moose::Role;
#
#has 'class' => (
#    is => 'rw',
#    isa => 'Str',
#);
#
#has 'widget' => ()
#
#before '_process_options' => sub {
#    my $class   = shift;
#    my $name    = shift;
#    my $options = shift;
#
#    if ( ! $options->{default} && ! $options->{builder} ) {
#        $options->{default} = sub {
#            my $self = shift;
#            my $att = $self->meta->get_attribute( $name );
#            
#            my $widget_class = $att->class;
#            my $widget = $widget_class->new( $att->args ? @{ $att->args } : () );
#            
#            return $widget;
#        };
#    }
#    if ( ! $options->{initializer} ) {
#        $options->{initializer} = sub {
#            
#            
#            my ( $self, $w, $set, $att ) = @_;
#            
#            my $properties = $att->properties;
#            
#            # apply properties to the widget
#            for my $p ( keys %{ $properties } ) {
#                my $value = $properties->{$p};
#                #$value = Gtk2::Image->new_from_stock( $value, 'button' ) if $p eq 'image';
#                $w->set( $p, $properties->{$p} );
#            }
#            
#            # connect to signals
#            my $sigmap = $att->signal_connect;
#            if ($sigmap) {
#                for my $signal (@{ $att->signal_connect } ) {
#                    my ( $name, $function, @args ) = @$signal;
#                    
#                    $w->signal_connect( $name => sub {
#                        my $w = shift;
#                        $self->$function( $w, [ @_ ] )
#                    }, @args );
#                    
#                }
#            }
#            
#            # call build functions
#            for my $function ( @{ $att->build } ) {
#                $self->$function( $w );
#            }
#            
#            $set->( $w );
#        }
#    }
#    unshift @{ $options->{build} }, sub {
#        my ( $self, $w ) = @_;
#        $w->set_default_size( @{ $options->{default_size} } ) if exists $options->{default_size};
#    };
#};

package Moose::Meta::Attribute::Custom::Trait::GappWidget;
sub register_implementation { 'Gapp::Meta::Attribute::Trait::GappWidget' };

1;
