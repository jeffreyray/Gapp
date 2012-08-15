package Gapp::TextBuffer;

use Moose;
use MooseX::SemiAffordanceAccessor;

extends 'Gapp::Widget';

has '+class' => (
    default => 'Gtk2::TextBuffer',
);


sub BUILDARGS {
    my $class = shift;
    my %args = @_ == 1 && is_HashRef( $_[0] ) ? %{$_[0]} : @_;
    
    for ( qw[has_selection text] ) {
        $args{properties}{$_} = delete $args{$_} if exists $args{$_}; 
    }
    __PACKAGE__->SUPER::BUILDARGS( %args );
}




1;


__END__

=pod

=head1 NAME

Gapp::TextBuffer - TextBuffer widget

=head1 OBJECT HIERARCHY

=over 4

=item L<Gapp::Widget>

=item +-- L<Gapp::TextBuffer>

=back

=head1 DELEGATED PROPERTIES

=over 4

=item has_selection

=item text

=back

=head1 AUTHORS

Jeffrey Ray Hallock E<lt>jeffrey.hallock at gmail dot comE<gt>

=head1 COPYRIGHT & LICENSE

    Copyright (c) 2011-2012 Jeffrey Ray Hallock.

    This program is free software; you can redistribute it and/or
    modify it under the same terms as Perl itself.

=cut

