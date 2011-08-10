package Gapp::Label;

use Moose;
use MooseX::SemiAffordanceAccessor;

extends 'Gapp::Widget';

has '+class' => (
    default => 'Gtk2::Label',
);

has 'markup' => (
    is => 'rw',
    isa => 'Str|Undef',
);

has 'text' => (
    is => 'rw',
    isa => 'Str|Undef',
);


sub BUILDARGS {
    my $class = shift;
    my %args = @_ == 1 && is_HashRef( $_[0] ) ? %{$_[0]} : @_;
    
    if ( exists $args{text} ) {
        $args{args} = [ $args{text} ];
        #delete $args{text};
    }
    
   
    __PACKAGE__->SUPER::BUILDARGS( %args );
}

1;



__END__

=pod

=head1 NAME

Gapp::Label - Label Widget

=head1 OBJECT HIERARCHY

=over 4

=item L<Gapp::Widget>

=item +-- L<Gapp::Label>

=back

=head1 PROVIDED ATTRIBUTES

=over 4

=item B<markup>

=over 4

=item isa Str

=back

=item B<text>

=over 4

=item isa Str

=back

=back

=head1 AUTHORS

Jeffrey Ray Hallock E<lt>jeffrey.hallock at gmail dot comE<gt>

=head1 COPYRIGHT & LICENSE

    Copyright (c) 2011 Jeffrey Ray Hallock.

    This program is free software; you can redistribute it and/or
    modify it under the same terms as Perl itself.

=cut


