package Gapp::ComboBox;

use Moose;
use MooseX::SemiAffordanceAccessor;

use Gapp::CellRenderer;
use Gapp::Types qw( GappCellRenderer );

extends 'Gapp::Widget';
with 'Gapp::Meta::Widget::Native::Trait::FormField';


has '+class' => (
    default => 'Gtk2::ComboBox',
);

has 'data_func' => (
    is => 'rw',
    isa => 'Str|CodeRef|Undef',
);

has 'data_column' => (
    is => 'rw',
    isa => 'Int|Undef',
    default => 0,
);

has 'model' => (
    is => 'rw',
    isa => 'Maybe[Object]',
);

has 'renderer' => (
    is => 'rw',
    isa => GappCellRenderer,
    default => sub { Gapp::CellRenderer->new( class => 'Gtk2::CellRendererText', property => 'markup' ) },
    coerce => 1,
);

has 'values' => (
    is => 'rw',
    isa => 'Maybe[ArrayRef]',
);





# returns the value of the widget
sub get_field_value {
    my $self = shift;
    
    my $iter = $self->gtk_widget->get_active_iter;
    return undef if ! $iter;
    
    my $value = $self->gtk_widget->get_model->get( $iter, $self->data_column );
    return $value;
}

# sets the value of the widget
sub set_field_value {
    my ( $self, $value ) = @_;
    
    # clear widget if no value
    if ( ! defined $value ) {
        $self->gtk_widget->set_active( -1 );
    }
    
    # find value and set appropriately
    else {
        $self->gtk_widget->get_model->foreach( sub{
            my ( $model, $path, $iter ) = @_;
            my $check_value = $model->get( $iter, $self->data_column );
            if ( $value eq $check_value ) {
                $self->gtk_widget->set_active_iter( $iter );
                return 1;
            }
        });
    }

}

sub widget_to_stash {
    my ( $self, $stash ) = @_;
    $stash->store( $self->field, $self->get_field_value );
}

sub stash_to_widget {
    my ( $self, $stash ) = @_;
    $self->set_field_value( $stash->fetch( $self->field ) );
}

1;



__END__

=pod

=head1 NAME

Gapp::ComboBox - ComboBox Widget

=head1 OBJECT HIERARCHY

=over 4

=item L<Gapp::Widget>

=item +-- L<Gapp::ComboBox>

=back

=head1 PROVIDED ATTRIBUTES

=over 4

=item B<data_column>

=over 4

=item isa Int

=item default 0

=back

=item B<data_func>

=over 4

=item isa Str|CodeRef|Undef

=back

=item B<model>

=over 4

=item isa L<Gapp::ListStore>|Undef

=back

=item B<renderer>

=over 4

=item isa L<Gapp::CellRenderer>

=item default Gapp::CellRenderer->new( class => 'Gtk2::CellRendererText', property => 'markup' );

=back

=item B<values>

=over 4

=item isa ArrayRef

=back

=back 

=head1 AUTHORS

Jeffrey Ray Hallock E<lt>jeffrey.hallock at gmail dot comE<gt>

=head1 COPYRIGHT & LICENSE

    Copyright (c) 2011 Jeffrey Ray Hallock.

    This program is free software; you can redistribute it and/or
    modify it under the same terms as Perl itself.

=cut

