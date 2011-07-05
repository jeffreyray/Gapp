package Gapp::Window;

use Moose;
use MooseX::SemiAffordanceAccessor;
use MooseX::Types::Moose qw( HashRef );

extends 'Gapp::Container';

has '+class' => (
    default => 'Gtk2::Window',
);

has 'icon' => (
    is => 'rw',
    isa => 'Str|Undef',
);

has 'transient_for' => (
    is => 'rw',
    isa => 'Maybe[Gapp::Window]',
);

has 'modal' => (
    is => 'rw',
    isa => 'Maybe[Int]',
);


has 'position' => (
    is => 'rw',
    isa => 'Maybe[Str]',
);



sub BUILDARGS {
    my $class = shift;
    my %args = @_ == 1 && is_HashRef( $_[0] ) ? %{$_[0]} : @_;
    
    if ( exists $args{title} ) {
        $args{properties}{title} = $args{title};
        delete $args{title};
    }
    if ( exists $args{default_size} ) {
        $args{properties}{'default-width'} = $args{default_size}[0];
        $args{properties}{'default-height'} = $args{default_size}[1];
        delete $args{default_size};
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

=item ....+-- L<Gapp::Window>

=back

=head1 DELEGATES TO GTK

=head2 Attributes

=over 4

=item B<title>

=item B<default_size => [$width, $height]>

Takes an ArrayRef and delegates the contents to the C<default-width> and
C<default-height> properties.

=back 

=head1 AUTHORS

Jeffrey Ray Hallock E<lt>jeffrey.hallock at gmail dot comE<gt>

=head1 COPYRIGHT & LICENSE

    Copyright (c) 2011 Jeffrey Ray Hallock.

    This program is free software; you can redistribute it and/or
    modify it under the same terms as Perl itself.

=cut