package Gapp::NoticeBox;

use Moose;
use MooseX::SemiAffordanceAccessor;
use MooseX::Types::Moose qw( ArrayRef );

extends 'Gapp::Window';

has '_event_box' => (
    is => 'rw',
    isa => 'Gapp::EventBox',
    init_arg => undef,
    default => sub {
        Gapp::EventBox->new(
        
        )
    },
    lazy => 1,
);

has '+content' => (
    default => sub {
        [ $_[0]->_event_box ],
    },
    lazy => 1,
);


sub display {
    my ( $self, $notice ) = @_;
    #$self->show_all;
    
    my $ev = $self->_event_box;
    $ev->show;
    
    for ( $ev->gobject->get_children ) {
        $ev->gobject->remove( $_ );
    }
    
    $ev->gobject->add( $notice->gobject );
    $notice->gobject->show_all;
    
    
    $self->gobject->set( opacity => 0 );
    $self->gobject->show;
    
    my $gtkw = $self->gobject;
    my $screen = $gtkw->get_screen;
    my ($width, $height) = $gtkw->get_size;
    
    $gtkw->move( 0, $screen->get_height - $height - 40 );
    
    my $x = 0;
    Glib::Timeout->add(50, sub {
        return 0 if $x >= .95;
        $self->gobject->set( opacity => $x );
        $x += .07;
        return 1;
    });
}

sub hide {
    my $self = shift;
    my $x = $self->gobject->get( 'opacity' );
    Glib::Timeout->add(50, sub {
        if ( $x <= 0 ) {
            $self->gobject->set( opacity => 0 );
            return 0;
        }
        else {
            $self->gobject->set( opacity => $x );
            $x -= .07;
            return 1;
        }
    });   
}


1;

__END__

=pod

=head1 NAME

Gapp::Notification - Display a message in the system tray

=head1 OBJECT HIERARCHY

=over 4

=item L<Gapp::Widget>

=item +-- L<Gapp::Container>

=item ....+-- L<Gapp::Window>

=item ........+-- L<Gapp::Notification>

=back

=head1 AUTHORS

Jeffrey Ray Hallock E<lt>jeffrey.hallock at gmail dot comE<gt>

=head1 COPYRIGHT & LICENSE

    Copyright (c) 2011-2012 Jeffrey Ray Hallock.

    This program is free software; you can redistribute it and/or
    modify it under the same terms as Perl itself.

=cut