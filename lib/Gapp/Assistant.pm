package Gapp::Assistant;

use Moose;
use MooseX::SemiAffordanceAccessor;
use MooseX::Types::Moose qw( HashRef );

extends 'Gapp::Window';

has '+class' => (
    default => 'Gtk2::Assistant',
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

1;
