package Gapp::ToolItemGroup;

use Moose;
use MooseX::SemiAffordanceAccessor;

extends 'Gapp::Container';

has '+gclass' => (
    default => 'Gtk2::ToolItemGroup',
);

has 'label' => (
    is => 'rw',
    isa => 'Str',
    default => '',
);

sub BUILDARGS {
    my $class = shift;
    my %args = @_ == 1 && is_HashRef( $_[0] ) ? %{$_[0]} : @_;
    
    $args{args} = [exists $args{label} ? $args{label} : ''];
    
    for my $att ( qw(collapsed ellipsize header-relief label-widget) ) {
        $args{properties}{$att} = delete $args{$att} if exists $args{$att};
    }
    
    __PACKAGE__->SUPER::BUILDARGS( %args );
}

1;


__END__

=pod

=head1 NAME

Gapp::ToolPalette - Box widget

=head1 OBJECT HIERARCHY

=over 4

=item L<Gapp::Widget>

=item +-- L<Gapp::Container>

=item ....+-- L<Gapp::ToolItemGroup>

=back

=head1 DELEGATED PROPERTIES

=over 4

=item collapsed

=item ellipsize

=item header-relief

=item label

=item label-widget

=back

=head1 AUTHORS

Jeffrey Ray Hallock E<lt>jeffrey.hallock at gmail dot comE<gt>

=head1 COPYRIGHT & LICENSE

    Copyright (c) 2011-2012 Jeffrey Ray Hallock.

    This program is free software; you can redistribute it and/or
    modify it under the same terms as Perl itself.

=cut