package Gapp::Button;

use Moose;
use MooseX::SemiAffordanceAccessor;

extends 'Gapp::Widget';
with 'Gapp::Meta::Widget::Native::Role::HasAction';

has '+gclass' => (
    default => 'Gtk2::Button',
);

has 'label' => (
    is => 'rw',
    isa => 'Maybe[Str]',
);

has 'icon' => (
    is => 'rw',
    isa => 'Maybe[Str]',
);

has 'image' => (
    is => 'rw',
    isa => 'Maybe[Gapp::Image]',
);

has 'stock_id' => (
    is => 'rw',
    isa => 'Maybe[Str]',
);

sub BUILDARGS {
    my $class = shift;
    my %args = @_ == 1 && is_HashRef( $_[0] ) ? %{$_[0]} : @_;
    
    if ( exists $args{label} && ! $args{args} ) {
        $args{args} = [ $args{label} ];
        $args{constructor} = 'new_with_label';
    }
    
    __PACKAGE__->SUPER::BUILDARGS( %args );
}


1;


__END__

=pod

=head1 NAME

Gapp::Button - Button Widget

=head1 OBJECT HIERARCHY

=over 4

=item L<Gapp::Object>

=item +-- L<Gapp::Widget>

=item ....+-- L<Gapp::Button>

=back

=head2 Roles

=over 4

=item L<Gapp::Meta::Widget::Native::Role::HasAction>

=head1 PROVIDED ATTRIBUTES

=over 4

=item B<label>

=over 4

=item is rw

=item isa Maybe[Str]

=back

The label text to use on the button.


=item B<icon>

=over 4

=item is rw

=item isa Maybe[Str]

=back

The stock item to use for the button image. See C<stock_id> to create a button with a stock image
and stock label.

=item B<image>

=over 4

=item is rw

=item isa Maybe[Gapp::Image]

=back

The image to use on the button.

=item B<stock_id>

=over 4

=item is rw

=item isa Maybe[Str]

=back

The stock item to use on the button.

=back

=head1 AUTHORS

Jeffrey Ray Hallock E<lt>jeffrey.hallock at gmail dot comE<gt>

=head1 COPYRIGHT & LICENSE

    Copyright (c) 2011-2012 Jeffrey Ray Hallock.

    This program is free software; you can redistribute it and/or
    modify it under the same terms as Perl itself.

=cut
