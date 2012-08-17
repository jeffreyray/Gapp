package Gapp::Toolbar;

use Moose;
use MooseX::SemiAffordanceAccessor;
extends 'Gapp::Container';

has '+gclass' => (
    default => 'Gtk2::Toolbar',
);

has 'icon_size' => (
    is => 'rw',
    isa => 'Str',
);

sub BUILDARGS {
    my $class = shift;
    my %args = @_ == 1 && is_HashRef( $_[0] ) ? %{$_[0]} : @_;
    
    if ( exists $args{style} ) {
        $args{properties}{'toolbar-style'} = $args{style};
        delete $args{style};
    }
    
    __PACKAGE__->SUPER::BUILDARGS( %args );
}

1;


__END__

=pod

=head1 NAME

Gapp::Window - Window Widget

=head1 OBJECT HIERARCHY

=over 4

=item L<Gapp::Widget>

=item +-- L<Gapp::Container>

=item ....+-- L<Gapp::Toolbar>

=back

=head1 PROVIDED ATTRIBUTES

=over 4

=item B<icon_size>

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
