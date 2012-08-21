package Gapp::ToolButton;

use Moose;
use MooseX::Types::Moose qw( ArrayRef );
use MooseX::SemiAffordanceAccessor;

extends 'Gapp::ToolItem';
with 'Gapp::Meta::Widget::Native::Role::HasIcon';
with 'Gapp::Meta::Widget::Native::Role::HasLabel';
with 'Gapp::Meta::Widget::Native::Role::HasStockId';



has '+gclass' => (
    default => 'Gtk2::ToolButton',
);

has 'icon_size' => (
    is => 'rw',
    isa => 'Str',
    default => 'dnd',
);



before '_build_gobject' => sub {
    my $self = shift;
    
    my $action = $self->action;
    $action = is_ArrayRef( $action ) ? $action->[0] : $action;
    
    if ( $action ) {
        my $icon = $self->icon ? $self->icon : $action->icon;
        my $label = defined $self->label ? $self->label : $action->label;
        $self->set_constructor( 'new' );
        $self->set_args ( [Gtk2::Image->new_from_stock( $icon , $self->icon_size ), $label] );
    }
    
    elsif ( $self->stock_id ) {
        $self->set_constructor( 'new_from_stock' );
        $self->set_args( [ $self->stock_id] );
    }
    elsif ( $self->icon ) {
        $self->set_constructor( 'new' );
        $self->set_args ( [Gtk2::Image->new_from_stock( $self->icon , $self->icon_size ), defined $self->label ? $self->label : ''] );
    }
    else {
        $self->set_constructor( 'new' );
        $self->set_args ( [Gtk2::Image->new_from_stock( 'gtk-dialog-error' , $self->icon_size ), defined $self->label ? $self->label : ''] );
    }
};


1;



__END__

=pod

=head1 NAME

Gapp::ToolButton - ToolButton Widget

=head1 OBJECT HIERARCHY

=over 4

=item L<Gapp::Object>

=item +-- L<Gapp::Widget>

=item ....+-- L<Gapp::ToolItem>

=item ........+-- L<Gapp::ToolButton>

=back

=head2 Roles

=over 4

=item L<Gapp::Meta::Widget::Native::Role::HasIcon>

=item L<Gapp::Meta::Widget::Native::Role::HasLabel>

=item L<Gapp::Meta::Widget::Native::Role::HasStockId>

=back

=head1 PROVIDED ATTRIBUTES

=over 4

=item B<icon_size>

=over 4

=item is rw

=item isa Str

=item default dnd

=back

The size of the icons in the toolbar. 

=back

=head1 AUTHORS

Jeffrey Ray Hallock E<lt>jeffrey.hallock at gmail dot comE<gt>

=head1 COPYRIGHT & LICENSE

    Copyright (c) 2011-2012 Jeffrey Ray Hallock.

    This program is free software; you can redistribute it and/or
    modify it under the same terms as Perl itself.

=cut
