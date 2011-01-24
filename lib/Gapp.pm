package Gapp;

use Gtk2 '-init';

our $VERSION = 0.02;
our $AUTHORITY = 'cpan:JHALLOCK';

use Moose ();
use Moose::Meta::Method;
use Moose::Exporter;

use MooseX::Method::Signatures;
use MooseX::Types::Moose qw( ArrayRef );

use Gapp::Meta::Attribute::Trait::DefaultWidget;
use Gapp::Meta::Attribute::Trait::GtkActionGroup;
use Gapp::Meta::Attribute::Trait::GtkButton;
use Gapp::Meta::Attribute::Trait::GtkLabel;
use Gapp::Meta::Attribute::Trait::GtkStatusIcon;
use Gapp::Meta::Attribute::Trait::GtkTextView;
use Gapp::Meta::Attribute::Trait::GtkToolbar;
use Gapp::Meta::Attribute::Trait::GtkUIManager;
use Gapp::Meta::Attribute::Trait::GtkWidget;
use Gapp::Meta::Attribute::Trait::GtkWindow;

Moose::Exporter->setup_import_methods(
    #as_is => ['method'],
    with_meta => ['widget'],
    also      => ['Moose' ],
);

sub init_meta {
    shift;
    return Moose->init_meta( @_,
        # metaclass => 'MyApp::Meta::Class',
        base_class => 'Gapp::Object',
    );
}

sub widget {   
    my $meta = shift;
    my $name = shift;

    Moose->throw_error('Usage: has \'name\' => ( key => value, ... )')
        if @_ % 2 == 1;
        
    my %args = @_;
    
    # apply GtkWidget trait
    $args{traits} = [] if ! exists $args{traits};
    push @{ $args{traits} }, 'GtkWidget';
    
    # transform build to array ref
    
    $args{build} = ! exists $args{build} ?
                   [] :
                   ref $args{build} eq 'Array' ?
                   $args{build} :
                   [ $args{build} ];
    
    # pass on to moose to handle
    &Moose::has( $meta, $name, %args );
    
    # content of &Moose::has
    #my %options = ( definition_context => Moose::Util::_caller_info(), @_ );
    #my $attrs = ( ref($name) eq 'ARRAY' ) ? $name : [ ($name) ];
    #$meta->add_attribute( $_, %options ) for @$attrs;
}

sub _build_widget {
    my $self = shift;
}


1;
