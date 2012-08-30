package Gapp::FormButtons;

use Moose;
use MooseX::SemiAffordanceAccessor;

extends 'Gapp::HButtonBox';
with 'Gapp::Meta::Widget::Native::Role::FormElement';


use Gapp::Actions::Form qw( Ok Apply Cancel );


has 'apply_button' => (
    is => 'rw',
    isa => 'Maybe[Gapp::Button]',
    default => sub {
        Gapp::Button->new( action => [Apply] ),
    },
    lazy => 1,
);

has 'cancel_button' => (
    is => 'rw',
    isa => 'Maybe[Gapp::Button]',
    default => sub {
        Gapp::Button->new( action => [Cancel] ),
    },
    lazy => 1,
);

has 'ok_button' => (
    is => 'rw',
    isa => 'Maybe[Gapp::Button]',
    default => sub {
        Gapp::Button->new( action => [Ok], default => 1 ),
    },
    lazy => 1,
);

has '+content' => (
    default => sub {
        [ $_[0]->cancel_button, $_[0]->apply_button, $_[0]->ok_button ],
    },
    lazy => 1,
);

#after _build_gobject => sub {
#    my ( $self ) = @_;
#    if ( $self->form && $self->form->isa('Gapp::Window') ) {
#        $self->ok_button->gobject->set_can_default( 1 );
#        $self->form->gobject->set_default( $self->ok_button->gobject );
#    }
#};

1;


__END__

=pod

=head1 NAME

Gapp::FormButtons - FormButtons widget

=head1 OBJECT HIERARCHY

=over 4

=item L<Gapp::Object>

=item +-- L<Gapp::Widget>

=item +-- L<Gapp::Container>

=item ........+-- L<Gapp::Box>

=item ............+-- L<Gapp::ButtonBox>

=item ................+-- L<Gapp::HButtonBox>

=back

=head1 AUTHORS

Jeffrey Ray Hallock E<lt>jeffrey.hallock at gmail dot comE<gt>

=head1 COPYRIGHT & LICENSE

    Copyright (c) 2011-2012 Jeffrey Ray Hallock.

    This program is free software; you can redistribute it and/or
    modify it under the same terms as Perl itself.

=cut