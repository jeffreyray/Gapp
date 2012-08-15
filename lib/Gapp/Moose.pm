package Gapp::Moose;

our $VERSION = 0.01;
our $AUTHORITY = 'cpan:JHALLOCK';

use Moose;
use Moose::Meta::Method;
use Moose::Exporter;

use Gapp;
use Gapp::Gtk2;
use Gapp::Moose::Meta::Attribute::Trait::GappActionGroup;
use Gapp::Moose::Meta::Attribute::Trait::GappAssistant;
use Gapp::Moose::Meta::Attribute::Trait::GappBox;
use Gapp::Moose::Meta::Attribute::Trait::GappComboBox;
use Gapp::Moose::Meta::Attribute::Trait::GappButton;
use Gapp::Moose::Meta::Attribute::Trait::GappDateEntry;
use Gapp::Moose::Meta::Attribute::Trait::GappEventBox;
use Gapp::Moose::Meta::Attribute::Trait::GappFileChooserDialog;
use Gapp::Moose::Meta::Attribute::Trait::GappFileFilter;
use Gapp::Moose::Meta::Attribute::Trait::GappFrame;
use Gapp::Moose::Meta::Attribute::Trait::GappHBox;
use Gapp::Moose::Meta::Attribute::Trait::GappHButtonBox;
use Gapp::Moose::Meta::Attribute::Trait::GappImage;
use Gapp::Moose::Meta::Attribute::Trait::GappLabel;
use Gapp::Moose::Meta::Attribute::Trait::GappListStore;
use Gapp::Moose::Meta::Attribute::Trait::GappDefault;
use Gapp::Moose::Meta::Attribute::Trait::GappDialog;
use Gapp::Moose::Meta::Attribute::Trait::GappMenu;
use Gapp::Moose::Meta::Attribute::Trait::GappMenuBar;
use Gapp::Moose::Meta::Attribute::Trait::GappNoticeBox;
use Gapp::Moose::Meta::Attribute::Trait::GappScrolledWindow;
use Gapp::Moose::Meta::Attribute::Trait::GappSpinButton;
use Gapp::Moose::Meta::Attribute::Trait::GappStatusIcon;
use Gapp::Moose::Meta::Attribute::Trait::GappTable;
use Gapp::Moose::Meta::Attribute::Trait::GappTextBuffer;
use Gapp::Moose::Meta::Attribute::Trait::GappTextView;
use Gapp::Moose::Meta::Attribute::Trait::GappTimeEntry;
use Gapp::Moose::Meta::Attribute::Trait::GappToolbar;
use Gapp::Moose::Meta::Attribute::Trait::GappToolItemGroup;
use Gapp::Moose::Meta::Attribute::Trait::GappToolPalette;
use Gapp::Moose::Meta::Attribute::Trait::GappTreeView;
use Gapp::Moose::Meta::Attribute::Trait::GappUIManager;
use Gapp::Moose::Meta::Attribute::Trait::GappWindow;
use Gapp::Moose::Meta::Attribute::Trait::GappWidget;
use Gapp::Moose::Meta::Attribute::Trait::GappVBox;
use Gapp::Moose::Meta::Attribute::Trait::GappVButtonBox;

Moose::Exporter->setup_import_methods(
    with_meta => ['widget'],
    also      => ['Moose' ],
);

sub init_meta {
    shift;
    return Moose->init_meta( @_ );
}

sub widget {   
    my $meta = shift;
    my $name = shift;

    Moose->throw_error('Usage: widget \'name\' => ( key => value, ... )') if @_ % 2 == 1;

    my %args = @_;
    
    # apply GtkWidget trait
    $args{traits} = [] if ! exists $args{traits};
    push @{ $args{traits} }, 'GappWidget';

    # pass on to moose to handle
    &Moose::has( $meta, $name, %args );
}

1;





__END__

=head1 NAME

Gapp::Moose - Gapp widgets for your Moose classes

=head1 SYNOPSIS

  package Foo::Bar;
 
  use Gapp::Moose;

  widget 'label' => (
    is => 'ro',
    traits => [qw( GappLabel )],
    construct => {
        text => 'Hello World!'
    }
  )

  widget 'window' => (
    is => 'ro',
    traits => [qw( GappWindow GappDefault )],
    construct => sub {
        title => 'Gapp Application',
        content => [ $_[0]->label ],
        signal_connect => [
            [ 'delete-event' => sub { Gtk2->main_quit } ]
        ],
    },
  );



 package main;

 Foo::Bar->new->show_all;

 Gapp->main;
=head1 DESCRIPTION

L<Gapp::Moose> provides sugar for adding L<Gapp> widgets to your L<Moose>
classes.

=head1 SUGAR

=head2 C<widget>

Internally, this calls C<&Moose::has> to create a new attribute with the
C<GappWidget> trait applied. 

Alternatively, you could apply the GappWidget trait yourself

 has 'widget' => (
    traits => [qw( GappWidget )],
 );

=head1 AUTHORS

Jeffrey Ray Hallock, <jeffrey dot hallock at gmail dot com>

=head1 COPYRIGHT & LICENSE

Copyright 2011 Jeffrey Ray Hallock, All Rights Reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

