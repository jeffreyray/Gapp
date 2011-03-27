package Gapp::Button;

use Moose;
use MooseX::SemiAffordanceAccessor;

extends 'Gapp::Widget';

has '+class' => (
    default => 'Gtk2::Button',
);

has 'label' => (
    is => 'rw',
    isa => 'Str|Undef',
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

Gapp::Box - Box widget

=head1 OBJECT HIERARCHY

    Gapp::Widget
    +--Gapp::Container
      +--Gapp::Box

=head1 PROVIDED ATTRIBUTES

=over 4

=item label

=back

=head1 AUTHORS

Jeffrey Ray Hallock E<lt>jeffrey.hallock at gmail dot comE<gt>

=head1 COPYRIGHT & LICENSE

    Copyright (c) 2011 Jeffrey Ray Hallock.

    This program is free software; you can redistribute it and/or
    modify it under the same terms as Perl itself.

=cut