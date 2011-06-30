package Gapp;

our $VERSION = 0.20;

use Gtk2 '-init';

use Gapp::Action;
use Gapp::ActionGroup;
use Gapp::Assistant;
use Gapp::AssistantPage;
use Gapp::Button;
use Gapp::ButtonBox;
use Gapp::CellRenderer;
use Gapp::CheckButton;
use Gapp::ComboBox;
use Gapp::DateEntry;
use Gapp::Dialog;
use Gapp::Entry;
use Gapp::EventBox;
use Gapp::FileChooserDialog;
use Gapp::Form::Context;
use Gapp::Form::Stash;
use Gapp::HBox;
use Gapp::HButtonBox;
use Gapp::Image;
use Gapp::ImageMenuItem;
use Gapp::Label;
use Gapp::ListStore;
use Gapp::Menu;
use Gapp::MenuBar;
use Gapp::MenuItem;
use Gapp::MenuToolButton;
use Gapp::Notice;
use Gapp::NoticeBox;
use Gapp::ProgressBar;
use Gapp::RadioButton;
use Gapp::ScrolledWindow;
use Gapp::SimpleList;
use Gapp::SSNEntry;
use Gapp::Table;
use Gapp::ToggleButton;
use Gapp::Toolbar;
use Gapp::ToolButton;
use Gapp::TreeView;
use Gapp::TreeViewColumn;
use Gapp::UIManager;
use Gapp::VBox;
use Gapp::VButtonBox;
use Gapp::Widget;
use Gapp::Window;


use Gapp::Layout::Default;
our $Layout = Gapp::Layout::Default->Layout;

use Gapp::Meta::Widget::Native::Trait::ErrorDialog;
use Gapp::Meta::Widget::Native::Trait::Form;
use Gapp::Meta::Widget::Native::Trait::FormField;
use Gapp::Meta::Widget::Native::Trait::FromUIManager;
use Gapp::Meta::Widget::Native::Trait::OkCancelDialog;

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
VERSIONS WITH NO NOTICE. THE DOCUMENTATION MAY COVER FEATURES THAT ARE NOT
COMPLETE IN THEIR IMPLEMENTATION. THE DOCUMENTATION MAY ALSO BE LACKING.*
    
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

=head1 ACKNOWLEDGEMENTS

Thanks to everyone at Gtk2-Perl and Moose and all those who came before me for
making this module possible.

Special thanks to Jörn Reder, author of L<Gtk2::Ex::FormFactory>, which inspired
me to write Gapp. L<Gapp::TableMap> uses modified code directly from
L<Gtk2::Ex::FormFactory::Table> (see L<Gapp::TableMap> for more details.)

Special thanks to the authors and contributors of L<MooseX::Types>, which formed
the basis for L<Gapp::Actions> (see L<Gapp::Actions> for more details.)

=head1 AUTHORS

Jeffrey Ray Hallock E<lt>jeffrey.hallock at gmail dot comE<gt>

Individual packages in this module may have have multiple authors/and or
contributors. Please refer to the documentation of indivdual packages for
more information. (see L<Gapp::Actions>, L<Gapp::TableMap>)

=head1 COPYRIGHT & LICENSE

    Copyright (c) 2011 Jeffrey Ray Hallock.
    
    This program is free software; you can redistribute it and/or
    modify it under the same terms as Perl itself.
    
    Individual packages in this module may have have multiple copyrights and
    licenses. Please refer to the documentation of indivdual packages for more
    information. (see L<Gapp::Actions>, L<Gapp::TableMap>)

=cut









