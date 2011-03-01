package Gapp;

our $VERSION = 0.09;

use Gapp::Action;
use Gapp::ActionGroup;
use Gapp::Assistant;
use Gapp::AssistantPage;
use Gapp::CellRenderer;
use Gapp::Dialog;
use Gapp::HBox;
use Gapp::Image;
use Gapp::Label;
use Gapp::ListStore;
use Gapp::Menu;
use Gapp::MenuItem;
use Gapp::ImageMenuItem;
use Gapp::MenuToolButton;
use Gapp::UIManager;
use Gapp::Toolbar;
use Gapp::ToolButton;
use Gapp::TreeView;
use Gapp::TreeViewColumn;
use Gapp::Widget;
use Gapp::Window;
use Gapp::VBox;

use Gapp::Layout::Default;
our $Layout = Gapp::Layout::Default->Layout;

use Gapp::Meta::Widget::Native::Trait::ErrorDialog;
use Gapp::Meta::Widget::Native::Trait::Form;
use Gapp::Meta::Widget::Native::Trait::FormField;
use Gapp::Meta::Widget::Native::Trait::FromUIManager;


1;

__END__

=pod

=head1 NAME

Gapp - Post-modern Gtk+ applications

=head1 SYNOPSIS

  use Gapp;

  use Gapp::Actions::Basic qw( Quit );

  my $w = Gapp::Window->new(
      title => 'Gapp Application',
      signal_connect => [
          [ 'delete-event' => Quit ],
      ],
      content => [
          Gapp::HBox->new(
              content => [
                Gapp::Label->new(
                    text => 'hello world!'
                ),
                Gapp::Button->new(
                    label => 'close',
                    signal_connect => [
                        [ 'delete-event' => Quit ]
                    ],
                ),
              ]
          )
      ]
  );
  
  Gtk2->main;
    
=head1 DESCRIPTION

L<Gapp> is a layer over the L<Gtk2> library and makes designing Gtk+
applications in perl more perlish.

=head1 NEW VERSION WARNING

*THIS IS NEW SOFTWARE. IT IS STILL IN DEVELOPMENT. THE API MAY CHANGE IN FUTURE
VERSIONS WITH NO NOTICE.*

=head1 AUTHOR

Jeffrey Ray Hallock E<lt>jeffrey.hallock at gmail dot comE<gt>

=head1 COPYRIGHT

    Copyright (c) 2011 Jeffrey Ray Hallock. All rights reserved.
    This program is free software; you can redistribute it and/or
    modify it under the same terms as Perl itself.

=cut








