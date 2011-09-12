package Gapp::Assistant;

use Moose;
use MooseX::SemiAffordanceAccessor;
use MooseX::Types::Moose qw( HashRef );

use MooseX::Types::Moose qw( Undef );
use Gapp::Types qw( GappActionOrArrayRef );

extends 'Gapp::Window';

has '+class' => (
    default => 'Gtk2::Assistant',
);

has 'forward_page_func' => (
    is => 'rw',
    isa => GappActionOrArrayRef|Undef,
);

sub find_page {
    my ( $self, $page_name ) = @_;
    
    if ( ! defined $page_name ) {
        $self->meta->throw_errow(
            qq[you did not supply a page name,\n] .
            qq[usage: Gapp::Assistant::find_page( $self, $page_name )]
        );
        return;
    }
    
    for my $page ( $self->children ) {
        return $page if $page->name eq $page_name;
    }
}

sub set_current_page {
    my ( $self, $page_name ) = @_;
    
    if ( ! defined $page_name ) {
        $self->meta->throw_errow(
            qq[you did not supply a page name,\n] .
            qq[usage: Gapp::Assistant::find_page( $self, $page_name )]
        );
        return;
    }
    
    for my $page ( $self->children ) {
        if ( $page->name eq $page_name ) {
            $self->gtk_widget->set_current_page( $page->num );
        }
    }
}

sub current_page {
    my ( $self ) = @_;
    my $num = $self->gtk_widget->get_current_page;
    
    for my $page ( $self->children ) {
        return $page if $page->num == $num;
    }
}



sub BUILD {
    my $self = shift;
    $self->signal_connect( 'prepare' => sub {
        my ( $self ) = @_;
        my $page = $self->current_page;
        $page->validate if $page->validator;
    }, $self);
}





1;
