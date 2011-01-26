package Gapp::Meta::Attribute::Trait::GtkWidget;
use Moose::Role;

use MooseX::Types::Moose qw( ArrayRef CodeRef HashRef Str );

has 'args' => (
    is => 'rw',
    isa => ArrayRef,
);

has 'class' => (
    is => 'rw',
    isa => Str,
);

has 'properties' => (
    is => 'rw',
    isa => HashRef,
);

has 'signal_connect' => (
    is => 'rw',
    isa => HashRef,
);

has 'build' => (
    is => 'rw',
    isa => ArrayRef,
    default => sub { [ ] },
);

has 'default_size' => (
    is => 'rw',
    isa => ArrayRef,
    default => sub { [ ] },
);

before '_process_options' => sub {
    my $class   = shift;
    my $name    = shift;
    my $options = shift;

    if ( ! $options->{default} && ! $options->{builder} ) {
        $options->{default} = sub {
            my $self = shift;
            my $att = $self->meta->get_attribute( $name );
            
            my $widget_class = $att->class;
            my $widget = $widget_class->new( $att->args ? @{ $att->args } : () );
            
            return $widget;
        };
    }
    if ( ! $options->{initializer} ) {
        $options->{initializer} = sub {
            
            
            my ( $self, $w, $set, $att ) = @_;
            
            my $properties = $att->properties;
            
            # apply properties to the widget
            for my $p ( keys %{ $properties } ) {
                my $value = $properties->{$p};
                #$value = Gtk2::Image->new_from_stock( $value, 'button' ) if $p eq 'image';
                $w->set( $p, $properties->{$p} );
            }
            
            # connect to signals
            my $sigmap = $att->signal_connect;
            if ($sigmap) {
                for my $signal ( keys %{ $att->signal_connect } ) {
                    
                    my $function = $sigmap->{ $signal };
                    
                    $w->signal_connect( $signal => sub {
                        my $w = shift;
                        $self->$function( $w, [ @_ ] )
                    } );
                    
                }
            }
            
            # call build functions
            for my $function ( @{ $att->build } ) {
                $self->$function( $w );
            }
            
            $set->( $w );
        }
    }
    unshift @{ $options->{build} }, sub {
        my ( $self, $w ) = @_;
        $w->set_default_size( @{ $options->{default_size} } ) if exists $options->{default_size};
    };
};

package Moose::Meta::Attribute::Custom::Trait::GtkWidget;
sub register_implementation { 'Gapp::Meta::Attribute::Trait::GtkWidget' };

1;
