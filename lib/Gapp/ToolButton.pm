package Gapp::ToolButton;

use Moose;
use MooseX::Types::Moose qw( ArrayRef );
use MooseX::SemiAffordanceAccessor;

extends 'Gapp::ToolItem';


has '+gclass' => (
    default => 'Gtk2::ToolButton',
);

has 'stock_id' => (
    is => 'rw',
    isa => 'Str',
);

has 'icon' => (
    is => 'rw',
    isa => 'Str',
);

has 'icon_size' => (
    is => 'rw',
    isa => 'Str',
    default => 'dnd',
);

has 'label' => (
    is => 'rw',
    isa => 'Maybe[Str]',
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








#sub BUILDARGS {
#    my $class = shift;
#    my %args = @_ == 1 && is_HashRef( $_[0] ) ? %{$_[0]} : @_;
#    
#    #$args{label} = $args{action}->label if $args{action} && ! exists $args{label};
#    #$args{icon} = $args{action}->icon if $args{action} && ! exists $args{icon};
#    
#    if ( exists $args{stock_id} ) {
#        $args{constructor} = 'new_from_stock';
#        $args{args} = [ $args{stock_id} ];
#    }
#    else {
#        if ( ! $args{icon} ) {
#            warn 'must set icon or stock_id';
#        }
#        else {
#            $args{args} = [
#                Gtk2::Image->new_from_stock( $args{icon} , 'dnd' ),
#                $args{label},
#            ];
#        }
#    }
#    
#    __PACKAGE__->SUPER::BUILDARGS( %args );
#}

1;



__END__

=pod

=head1 NAME

Gapp::ToolButton - ToolButton Widget

=head1 OBJECT HIERARCHY

=over 4

=item L<Gapp::Widget>

=item ....+-- L<Gapp::ToolItem>

=item ........+-- L<Gapp::ToolButton>

=back

=head1 PROVIDED ATTRIBUTES

=over 4

=item B<icon>

=over 4

=item isa Str

=back

=item B<label>

=over 4

=item isa Str

=back

=item B<stock_id>

=over 4

=item isa Str

=back

=back

=head1 AUTHORS

Jeffrey Ray Hallock E<lt>jeffrey.hallock at gmail dot comE<gt>

=head1 COPYRIGHT & LICENSE

    Copyright (c) 2011-2012 Jeffrey Ray Hallock.

    This program is free software; you can redistribute it and/or
    modify it under the same terms as Perl itself.

=cut
