package Gapp;

use Gtk2 '-init';

our $VERSION = 0.03.1;
our $AUTHORITY = 'cpan:JHALLOCK';

use Moose ();
use Moose::Meta::Method;
use Moose::Exporter;

use MooseX::Method::Signatures;
use MooseX::Types::Moose qw( ArrayRef );

use Gapp::Meta::Attribute::Trait::DefaultWidget;
use Gapp::Meta::Attribute::Trait::GtkActionGroup;
use Gapp::Meta::Attribute::Trait::GtkButton;
use Gapp::Meta::Attribute::Trait::GtkImage;
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





__END__

=head1 NAME

Gapp - Rapid application development

=head1 SYNOPSIS

 package MyObject;
 use Gapp;

 widget 'window' => (
    is => 'ro',
    traits => [ qw/GtkWindow DefaultWidget/ ],
    build => sub {
        ( $self, $widget ) = @_;
        $widget->add( $self->label );
    },
    signal_connect => {
        'delete-event' => sub { Gtk2->main_quit },
    }
 );

 widget 'label' => (
    is => 'ro',
    traits => [ qw/GtkLabel/ ],
    text => 'Hello World!',
 );

 package main;
 MyObject->show_all;

=head1 DESCRIPTION

Gapp makes construction of Gtk2 applications quick and easy.

=head1 SUGAR

Gapp is an extension of Moose and provides some of its own sugar to aid in the
development of your application objects.

=head2 C<widget>

Internally, this calls C<&Moose::has> to create a new object attribute which has
the C<GtkWidget> trait applied. The GtkWidget trait adds some properties to the
attribute which can be set and affect attributes behavior. These include the
C<build>, C<properties>, and C<signal_connect> parameters. See
L<Gapp::Meta::Attribute::Trait::GtkWidget> for more information.

* Alternatively, you could not use the C<widget> sugar function and apply
the GtkWidget trait to the attribute yourself.

=head1 AUTHOR

Jeffrey Ray Hallock, <jeffrey dot hallock at gmail dot com>

=head1 COPYRIGHT & LICENSE

Copyright 2010 Jeffrey Ray Hallock, All Rights Reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

