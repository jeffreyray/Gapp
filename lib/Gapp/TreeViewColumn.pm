package Gapp::TreeViewColumn;

use Moose;
extends 'Gapp::Widget';

use Gapp::CellRenderer;
use Gapp::Util;
use Gapp::Types qw( GappCellRenderer GappTreeViewColumn );

use Moose::Util;
use MooseX::Types::Moose qw( ArrayRef HashRef );

has '+class' => (
    default => 'Gtk2::TreeViewColumn',
);

has 'name' => (
    is => 'rw',
    isa => 'Str',
    default => '',
);

has 'renderer' => (
    is => 'rw',
    isa => GappCellRenderer,
    default => sub { Gapp::CellRenderer->new( class => 'Gtk2::CellRendererText', property => 'markup' ) },
    coerce => 1,
);

has 'data_func' => (
    is => 'rw',
    isa => 'Str|CodeRef|Undef',
);

has 'data_column' => (
    is => 'rw',
    isa => 'Int|Undef',
    default => undef,
);

sub BUILDARGS {
    my $class = shift;
    my %args = @_ == 1 && is_HashRef( $_[0] ) ? %{$_[0]} : @_;
    
    if ( exists $args{title} ) {
        $args{properties}{title} = $args{title};
        delete $args{title};
    }
    __PACKAGE__->SUPER::BUILDARGS( %args );
}

1;



__END__

=pod

=head1 NAME

Gapp::TreeViewColumn - TreeViewColumn Widget

=head1 OBJECT HIERARCHY

=over 4

=item L<Gapp::Widget>

=item +-- L<Gapp::TreeViewColumn>

=back

=head1 PROVIDED ATTRIBUTES

=over 4

=item B<data_column>

=over 4

=item isa: Int

=item default: 0

=back

=item B<data_func>

=over 4

=item isa: Str|CodeRef|Undef

=back

=item B<name>

=over 4

=item isa: Str

=item default: undef

=back

=item B<renderer>

=over 4

=item isa: L<Gapp::CellRenderer>

=item default: Gapp::CellRenderer->new( class => 'Gtk2::CellRendererText', property => 'markup' );

=back

=item B<values>

=over 4

=item isa: ArrayRef

=back

=back

=head1 DELEGATES TO GTK

=head2 Attributes

=over 4

=item B<title>

=back 

=head1 AUTHORS

Jeffrey Ray Hallock E<lt>jeffrey.hallock at gmail dot comE<gt>

=head1 COPYRIGHT & LICENSE

    Copyright (c) 2011 Jeffrey Ray Hallock.

    This program is free software; you can redistribute it and/or
    modify it under the same terms as Perl itself.

=cut


