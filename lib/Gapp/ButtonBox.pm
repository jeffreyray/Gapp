package Gapp::ButtonBox;

use Moose;
use MooseX::SemiAffordanceAccessor;

use Carp;
use Gapp::Button;
use Gapp::Types qw( GappWidget GappActionOrArrayRef );

extends 'Gapp::Container';

has '+class' => (
    default => 'Gtk2::ButtonBox',
);

has 'buttons' => (
    is => 'rw',
    isa => 'Maybe[ArrayRef]',
);


before '_construct_gtk_widget' => sub {
    my ( $self ) = @_;
    
    if ( $self->buttons && ! @{ $self->content } ) {
        
        my @content;
        
        for ( @{ $self->buttons } ) {
            
            if ( is_GappWidget( $_ ) ) {
                push @content, $_;
            }
            elsif ( is_GappActionOrArrayRef( $_ ) ) {
                push @content, Gapp::Button->new( action => $_ );
            }
            else {
                carp qq[invalid value ($_) passed to buttons attribute: ] .
                qq[ must be a GappWidget or a GappAction ];
            }
            
        }
        
        $self->set_content( \@content );
    }
};

1;


__END__

=pod

=head1 NAME

Gapp::ButtonBox - ButtonBox widget

=head1 OBJECT HIERARCHY

=over 4

=item L<Gapp::Widget>

=item +-- L<Gapp::Container>

=item ....+-- L<Gapp::Box>

=item ........+-- L<Gapp::ButtonBox>

=back

=head1 AUTHORS

Jeffrey Ray Hallock E<lt>jeffrey.hallock at gmail dot comE<gt>

=head1 COPYRIGHT & LICENSE

    Copyright (c) 2011 Jeffrey Ray Hallock.

    This program is free software; you can redistribute it and/or
    modify it under the same terms as Perl itself.

=cut