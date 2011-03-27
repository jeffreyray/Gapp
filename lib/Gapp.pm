package Gapp;

our $VERSION = 0.11;

use Gtk2 '-init';

use Gapp::Action;
use Gapp::ActionGroup;
use Gapp::Assistant;
use Gapp::AssistantPage;
use Gapp::Button;
use Gapp::CellRenderer;
use Gapp::CheckButton;
use Gapp::ComboBox;
use Gapp::Dialog;
use Gapp::Entry;
use Gapp::HBox;
use Gapp::Image;
use Gapp::Label;
use Gapp::ListStore;
use Gapp::Menu;
use Gapp::MenuItem;
use Gapp::ImageMenuItem;
use Gapp::MenuToolButton;
use Gapp::RadioButton;
use Gapp::Table;
use Gapp::ToggleButton;
use Gapp::Toolbar;
use Gapp::ToolButton;
use Gapp::TreeView;
use Gapp::TreeViewColumn;
use Gapp::UIManager;
use Gapp::VBox;
use Gapp::Widget;
use Gapp::Window;


use Gapp::Layout::Default;
our $Layout = Gapp::Layout::Default->Layout;

use Gapp::Meta::Widget::Native::Trait::ErrorDialog;
use Gapp::Meta::Widget::Native::Trait::Form;
use Gapp::Meta::Widget::Native::Trait::FormField;
use Gapp::Meta::Widget::Native::Trait::FromUIManager;

sub main { Gtk2->main };
sub quit { Gtk2->main_quit };


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
                  Gapp::Label->new( text => 'hello world!' ),
                  Gapp::Button->new( action => Quit ),
                ]
            )
        ]
    );

    Gapp->main;
  
=head1 NEW VERSION WARNING

*THIS IS NEW SOFTWARE. IT IS STILL IN DEVELOPMENT. THE API MAY CHANGE IN FUTURE
VERSIONS WITH NO NOTICE.*
    
=head1 DESCRIPTION

Gapp is a framework for building GUI applications.

The main goal of Gapp is to make Perl 5 GUI programming easier and less tedious.
With Gapp you can to think more about what you want to do and less about
choreographing widgets or keeping them (and your data) up to date.

=head2 New to Gapp?

The best place to start is the L<Gapp::Manual>.

=head1 PROVIDED METHODS

=over 4

=item B<main>

Delegates to C<Gtk2::main>.

=item B<quit>

Delegates to C<Gtk2::main_quit>.

=back

=head1 AUTHOR

Jeffrey Ray Hallock E<lt>jeffrey.hallock at gmail dot comE<gt>

=head1 COPYRIGHT

    Copyright (c) 2011 Jeffrey Ray Hallock. All rights reserved.
    This program is free software; you can redistribute it and/or
    modify it under the same terms as Perl itself.

=cut









