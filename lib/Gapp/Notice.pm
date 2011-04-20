package Gapp::Notice;

use Moose;
use MooseX::SemiAffordanceAccessor;
use MooseX::StrictConstructor;

extends 'Gapp::HBox';

has 'image' => (
    is => 'rw',
    isa => 'Maybe[Str]',
);

has 'text' => (
    is => 'rw',
    isa => 'Str',
    default => '',
);

has 'action' => (
    is => 'rw',
);


before '_build_gtk_widget' => sub {
    my $self = shift;
    $self->set_content([
        $self->image ?
        Gapp::EventBox->new(
            content => [ Gapp::Image->new( stock => [ $self->image, 'dnd' ] ) ],
            $self->action ? ( signal_connect => [ ['button-release-event' => $self->action] ] ) : () ) :
        (),
        
        Gapp::EventBox->new(
            content => [ Gapp::Label->new( text => $self->text ) ],
            $self->action ? ( signal_connect => [ ['button-release-event' => $self->action] ] ) : (),
        ),
    ]);
};

1;
