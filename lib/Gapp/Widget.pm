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

# gtk-widget class
has 'class' => (
    is => 'rw',
    isa => 'Str',
    lazy_required => 1,
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

# the container of the gtk widget
#has 'gtk_container' => (
#    isa => 'Maybe[Gtk2::Widget]',
#    reader => '_gtk_container',
#    writer => 'set_gtk_container',
#);
#
#sub gtk_container {
#    $_[0]->_gtk_container || $_[0]->_gtk_widget;
#}



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
sub _apply_builders {
    my ( $self ) = @_;
    no warnings;
    $self->find_layout->build_widget( $self );
}

# call builder method from layout
sub _apply_stylers {
    my ( $self ) = @_;
    no warnings;
    $self->find_layout->style_widget( $self );
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
        
        if ( is_GappAction( $action ) ) {
            $self->gtk_widget->signal_connect( $name => sub {
                my ( $gtkw, @gtkargs ) = @_;
                $action->perform( $self, \@args, $gtkw,  \@gtkargs );
            });
        }
        else {
            $self->gtk_widget->signal_connect( $name => sub {
                my ( $gtkw, @gtkargs ) = @_;
                $action->( $self, \@args, $gtkw,  \@gtkargs );
            });
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

    $self->_apply_stylers;
    my $w = $self->_construct_gtk_widget( @_ );
    $self->_apply_properties;
    $self->_apply_signals;
    $self->_apply_builders;
    $self->_apply_customize;
    
    return $w;
}


has 'layout' => (
    is => 'rw',
    isa => GappLayout|Undef,
    predicate => 'has_layout',
    #lazy_build => 1,
    #trigger => \&_on_set_layout,
    coerce => 1,
);

has '_used_layout' => (
    is => 'rw',
    isa => GappLayout|Undef,
    clearer => '_clear_used_layout',
    #lazy_build => 1,
    #trigger => \&_on_set_layout,
    #coerce => 1,
);


sub find_layout {
    my ( $self, $default ) = @_;
    return $self->_used_layout if $self->_used_layout;
    
    if ( $self->layout ) {
        $self->_set_used_layout( $self->layout );
    }
    else {
        if ( $self->parent ) {
            $self->_set_used_layout( $self->parent->find_layout );
        }
        else {
            no warnings;
            $self->_set_used_layout( $default || $Gapp::Layout || Gapp::Layout::Default->Layout );
        }
    }
    return $self->_used_layout;
}

sub _forget_layout {
    my ( $self ) = @_;
    $self->_clear_used_layout;
    
    if ( $self->can('children') ) {
        $_->_forget_layout for $self->children;
    }
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

sub get_property {
    my ( $self, $name ) = @_;
    $self->properties->{$name};
}

sub find_ancestors {
    my ( $self ) = @_;
    my $parent = $self->parent;
    return $parent ? ( $parent, $parent->find_ancestors ) : ();
}

sub find_toplevel {
    my ( $self ) = @_;
    my @ancestors = $self->find_ancestors;
    
    print "---->", $self->parent, "\n";
    
    return @ancestors ? $ancestors[-1] : $self;
}


__END__

=pod

=head1 NAME

Gapp::Widget - The base class for all Gapp widgets

=head1 OBJECT HIERARCHY

=over 4

=item L<Gapp::Widget>

=back

=head1 DESCRIPTION

All Gapp widgets inherit from L<Gapp::Widget>.

=head1 PROVIDED ATTRIBUTES

=over 4

=item B<args>

=over 4

=item isa: ArrayRef|Undef

=item default: undef

=back

If C<args> is set, the contents of the ArrayRef will be passed into the
constructor when the Gtk+ widget is instantiated. The example below will create
a popup window instead of a standard toplevel window.

 Gapp::Window->new( args => [ 'popup' ] );

=item B<class>

=over 4

=item isa: ClassName

=item required: lazy

=back

This is the class of the Gtk+ widget to be created. Most Gapp widgets provide
this in their class definition, but you can override it by passing in your own
value.

 Gapp::Window->new( class => 'Gtk2::Ex::CustomWindow' );

=item B<constructor>

=over 4

=item isa: Str|CodeRef

=item default: new

=back

This constructor is called on the C<class> to instantiate a Gtk+ widget. Change
the constructor if you want to use the helpers provided by Gtk+ like
C<new_with_label> or C<new_with_mnemonic>.

=item B<customize>

=over 4

=item isa: CodeRef|Undef

=item default: undef

=back

Setting the C<customize> attribute allows you to tweak the Gtk+ widget after it
has been instantiated. Use this sparingly, you should define the appearnce of
your widgets using L<Gapp::Layout>.

If you find you need to use C<customize> because parts of Gapp are incomplete,
or could be remedied by more robustness, please file a bug or submit a patch.

=item B<expand>

=over 4

=item isa: Bool

=item default: 0

=back

If the widget should expand inside it's container. (Tables widgets ignore this
value because widget expansion is determind by the L<Gapp::TableMap>)

=item B<fill>

=over 4

=item isa: Bool

=item default: 0

=back

If the widget should fill it's container. (Tables widgets ignore this value
because widget layout is determind by the L<Gapp::TableMap>)

=back

=item B<gtk_widget>

=over 4

=item isa: Object

=item default: 0

=back

The actual Gtk+ widget. The widget will be constructed the first time it is
requested. After the Gtk+ widget has been constructed, changes you make to the
Gapp layer will not be reflected in the Gtk+ widget.

=item B<layout>

=over 4

=item isa: L<Gapp::Layout::Object>

=item default: L<Gapp::Layout::Default>

=back

The layout used to determine widget positioning.

=item B<padding>

=over 4

=item isa: Int

=item default: 0

=back

Padding around the widget.

=item B<parent>

=over 4

=item isa: L<Gapp::Widget>|Undef

=item default: undef

=back

The parent widget.

=item B<properties>

=over 4

=item isa: HashRef

=item handles:

=over 4

=item get:

get_property

=item set:

set_property

=back

The the properties supplied will be passed on to the Gtk+ widget during
construction. See the documentation for the corresponding Gtk+ widget for
valid properies.


=head1 AUTHORS

Jeffrey Ray Hallock E<lt>jeffrey.hallock at gmail dot comE<gt>

=head1 COPYRIGHT & LICENSE

    Copyright (c) 2011 Jeffrey Ray Hallock.

    This program is free software; you can redistribute it and/or
    modify it under the same terms as Perl itself.

=cut
