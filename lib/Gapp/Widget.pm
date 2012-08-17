package Gapp::Widget;

use Moose;
use MooseX::SemiAffordanceAccessor;
use MooseX::StrictConstructor;
extends 'Gapp::Object';

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

# tooltip to display
has 'tooltip' => (
    is => 'rw',
    isa => 'Maybe[Str]',
);

# padding around widget in container
has 'padding' => (
    is => 'rw',
    isa => 'Int',
    default => 0,
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

1;

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

 Gapp::Window->new( gclass => 'Gtk2::Ex::CustomWindow' );

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

=item B<gobject>

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

    Copyright (c) 2011-2012 Jeffrey Ray Hallock.

    This program is free software; you can redistribute it and/or
    modify it under the same terms as Perl itself.

=cut
