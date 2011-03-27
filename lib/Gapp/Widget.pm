package Gapp::Widget;

use Moose;
use MooseX::LazyRequire;
use MooseX::SemiAffordanceAccessor;
use MooseX::StrictConstructor;
use MooseX::Types::Moose qw( ArrayRef HashRef Str Undef );

use Gtk2;
use Gapp::Layout::Default;
use Gapp::Types qw( GappAction GappLayout );

# passed to gtk-widget constructor
has 'args' => (
    is => 'rw',
    isa => 'Maybe[ArrayRef]',
);

# the method/function used to construct the widget
has 'constructor' => (
    is => 'rw',
    isa => 'Str',
    default => 'new',
);

# allow user to customize widget, called after widget is built
has 'customize' => (
    is => 'rw',
    isa => 'CodeRef|Undef',
);


# gtk-widget class
has 'class' => (
    is => 'rw',
    isa => 'Str',
    lazy_required => 1,
);

# if the widget should expand its container
has 'expand' => (
    is => 'rw',
    isa => 'Bool',
    default => 1 ,
);

# if the widget should fill its container
has 'fill' => (
    is => 'rw',
    isa => 'Bool',
    default => 1 ,
);

# the actual gtk-widget
has 'gtk_widget' => (
    is => 'rw',
    isa => 'Object',
    lazy_build => 1,
    handles => [qw( show show_all hide )],
);

# call customize code-ref if set
sub _apply_customize {
    my ( $self ) = @_;
    $self->customize->( $self, $self->gtk_widget ) if $self->customize;
}

# call builder method from layout
sub _apply_layout {
    my ( $self ) = @_;
    no warnings;
    $self->layout->build_widget( $self );
}

# apply any properties to the gtk_widget
sub _apply_properties {
    my ( $self ) = @_;
    for my $p ( keys %{ $self->properties } ) {
        my $value = $self->properties->{$p};
        $self->gtk_widget->set( $p, $self->properties->{$p} );
    }
}

# apply any signals to the gtk_widget
sub _apply_signals {
    my ( $self ) = @_;

    # apply signals to the widget
    for my $s ( @{ $self->connected_signals } ) {
        my ( $name, $action, @args ) = @$s;
        use Scalar::Util qw( blessed );
        $action = $action->code if blessed $action && $action->isa( 'Gapp::Action' );
        
        if ( is_GappAction( $action ) ) {
            $self->gtk_widget->signal_connect( $name => sub {
                my $w = shift;
                $action->perform( $self, $w,  @_  )
            }, @args );
        }
        else {
            $self->gtk_widget->signal_connect( $name => sub {
                my $w = shift;
                $self->$action( $w,  @_  )
            }, @args );
        }
    }

}

# create and set the actual gtk_widget
sub _construct_gtk_widget {
    my ( $self ) = @_;
    
    my $gtk_class = $self->class;
    my $gtk_constructor = $self->constructor;
    
    # use any build-arguments if they exist
    my $w = $gtk_class->$gtk_constructor( $self->args ? @{$self->args} : ( ) );
    $self->set_gtk_widget( $w );
    return $w;
}

# construct and format the widget
sub _build_gtk_widget {
    my ( $self ) = @_;

    my $w = $self->_construct_gtk_widget( @_ );
    $self->_apply_properties;
    $self->_apply_signals;
    $self->_apply_layout;
    $self->_apply_customize;
    
    return $w;
}


has 'layout' => (
    is => 'rw',
    isa => GappLayout,
    lazy_build => 1,
    trigger => \&_on_set_layout,
    coerce => 1,
);

sub _build_layout {
    no warnings;
    $Gapp::Layout || Gapp::Layout::Default->Layout;
}

# for subclassing
sub _on_set_layout {
    
}

# padding around widget in container
has 'padding' => (
    is => 'rw',
    isa => 'Int',
    default => 0,
);

# the parent is set when the widget is added
# to a container widget
has 'parent' => (
    is => 'rw',
    isa => 'Gapp::Widget',
    weak_ref => 1,
);

# properties to apply to the widget
has 'properties' => (
    is => 'ro',
    isa => 'HashRef',
    default => sub { { } },
);

# signals to connect to
has 'connected_signals' => (
    is => 'ro',
    isa => 'ArrayRef',
    default => sub { [ ] },
    init_arg => 'signal_connect',
);

sub signal_connect {
    my ( $self, $name, $code, @args ) = @_;
    push @{ $self->connected_signals }, [ $name, $code, @args ];
}


has 'traits' => (
    is => 'rw',
    isa => 'ArrayRef',
    default => sub { [ ] },
);


sub BUILDARGS {
    my ( $self, %opts ) = @_;
    
    if ( exists $opts{alignment} ) {
        $opts{properties}{xalign} = $opts{alignment}[0];
        $opts{properties}{yalign} = $opts{alignment}[1];
        delete $opts{alignment};
    }
    
    $self->SUPER::BUILDARGS( %opts );
}


# we replace the new method with our own which applies any
# traits that may have been passed in
sub new {
    my ( $class, %args ) = @_;
    my ( $new_class, @traits ) = $class->interpolate_class(\%args);
    $new_class->_new( %args, ( scalar(@traits) ? ( traits => \@traits ) : () ) );
}

# access to Moose's new
sub _new {
    my ( $class, @args ) = @_;
    $class->SUPER::new( @args );
}

# create an anonamous class with the traits applied
# copied and modified from Moose::Meta::Attribute
sub interpolate_class {
    my ( $class, $options ) = @_;

    $class = ref( $class ) || $class;

    my @traits;
    if ( my $traits = $options->{traits} ) {
        
        my $i = 0;
        
        while ( $i < @$traits ) {
            
            my $trait = $traits->[$i++];
            
            next if ref($trait); # options to a trait we discarded
            
            # resolve short trait names
            $trait = Gapp::Util::resolve_widget_trait_alias( Widget => $trait )
                  || $trait;
            
            next if $class->does( $trait );
            
            push @traits, $trait;
                
            # are there options?
            push @traits, $traits->[$i++]
                if $traits->[$i] && ref($traits->[$i]);
                
        }
        
        # apply the traits
        if ( @traits ) {
            $class = Moose::Util::with_traits( $class, @traits );
        }
    }

    return ( wantarray ? ( $class, @traits ) : $class );
}

1;
