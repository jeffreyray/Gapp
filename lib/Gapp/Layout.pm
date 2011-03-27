package Gapp::Layout;
use strict;
use warnings;

use Gapp::Layout::Object;

use Sub::Exporter -setup => {
    exports => [qw/Layout build add to extends/],
    groups  => { default => [qw/Layout build add to extends/] },
};

{
    my %Layouts;

    sub Layout {
        my $caller = shift;
        return $Layouts{$caller} ||= Gapp::Layout::Object->new;
    }
}

sub extends {
    my ( $base ) = @_;
    caller()->Layout->set_parent( $base->Layout );
}

sub build {
    my ( $type, $definition ) = @_;
    caller()->Layout->add_builder( $type => $definition );
}

sub add {
    my ( $widget, @args ) = @_;
    caller()->Layout->add_packer( $widget, @args );
}

sub to {
    my ( $container, @args ) = @_;
    return ( $container, @args );
}


1;




__END__

=pod

=head1 NAME

Gapp::Layout - Define how widgets are displayed

=head1 SYNOPSIS

    package My::Custom::Layout;
    use Gapp::Layout;
    extends 'Gapp::Layout::Default';
    
    # center all entry texts
    build 'Gapp::Entry', sub {
        ( $layout, $widget ) = @_;
        $widget->gtk_widget->set( 'xalign', .5 );
        $layout->parent->build_widget( $widget );
    };
    
    # set spacing/borders for all vboxes
    build 'Gapp::VBox', sub {
        ( $layout, $widget ) = @_;
        $widget->gtk_widget->set( spacing => 12 );
        $widget->gtk_widget->set( 'border-width' => 6 );
        $layout->parent->build_widget( $widget );
    };
    
    # specify how buttons are packed into a button box
    add 'Gapp::Button', to 'Gapp::HButtonBox', sub {
        my ($l, $w, $c) = @_;
        $c->gtk_widget->pack_end(
            $w->gtk_widget,
            $w->expand,
            $w->fill,
            $w->padding
        );
    };
  
=head1 DESCRIPTION

L<Gapp::Layout> is a I<library for building layouts>. Creating a layout allows
you to customize the appearance of your widgets across your program in one
place. This also has the effect of keeping your gui design, application code,
and data structures separate.

Layouts are sub-classable and provide fine grained control of your program
apearance with a simple interface.

=head1 CREATING A LAYOUT

A layout is defined in a package. It is recomended that you inherit from
L<Gapp::Layout::Default>.
 
 package My::Custom::Layout;
 use Gapp::Layout;
 extends 'Gapp::Layout::Default';

=head2 Builders

Builders are used to customize the Gtk+ widget when it is constructed.

    # center all entry texts
    build 'Gapp::Entry', sub {
        ( $layout, $widget ) = @_;
        $widget->gtk_widget->set( 'xalign', .5 );
        $layout->parent->build_widget( $widget );
    };

=head2 Packers

Packers are used to position widgets in containers. 

    # specify how buttons are packed into a button box
    add 'Gapp::Button', to 'Gapp::HButtonBox', sub {
        my ( $layout, $widget, $container ) = @_;
        $container->gtk_widget->pack_end(
            $widget->gtk_widget,
            $widget->expand,
            $widget->fill,
            $widget->padding
        );
    };
    
The above example is pretty specific, but you can define something much more
general. Take the example below:

    # widgets always fill/expand vboxs
    add 'Gapp::Widget', to 'Gapp::VBox', sub {
        my ( $layout, $widget, $container ) = @_;
        $container->gtk_widget->pack_end(
            $widget->gtk_widget,
            1,
            1, #fill
            $widget->padding
        );
    };

This will make any L<Gapp::Widget> in a L<Gapp::VBox> expand and fill. You could
then override this, for a specific widget:

    # widgets always fill/expand vboxs
    add 'Gapp::Button', to 'Gapp::VBox', sub {
        my ( $layout, $widget, $container ) = @_;
        $container->gtk_widget->pack_end(
            $widget->gtk_widget,
            $widget->expand,
            $widget->fill,
            $widget->padding
        );
    };

=head1 EXPORTED FUNCTIONS

=over 4

=item B<add $widget_class, to $widget_class, \&add_func >

Set the packer for this widget\container combination.

=item B<build $widget_class, \&build_func >

Set the builder for this widget.

=item B<extends $class>

Use this if you want to subclass another layout.

=back

=head1 AUTHOR

Jeffrey Ray Hallock E<lt>jeffrey.hallock at gmail dot comE<gt>

=head1 COPYRIGHT

    Copyright (c) 2011 Jeffrey Ray Hallock.
    This program is free software; you can redistribute it and/or
    modify it under the same terms as Perl itself.

=cut


