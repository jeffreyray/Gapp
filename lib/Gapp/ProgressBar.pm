package Gapp::ProgressBar;

use Moose;
use MooseX::SemiAffordanceAccessor;

extends 'Gapp::Widget';

has '+class' => (
    default => 'Gtk2::ProgressBar',
);

sub BUILDARGS {
    my $class = shift;
    my %args = @_ == 1 && is_HashRef( $_[0] ) ? %{$_[0]} : @_;
    
    if ( exists $args{fraction} ) {
        $args{properties}{fraction} = $args{fraction};
        delete $args{fraction};
    }
    if ( exists $args{text} ) {
        $args{properties}{text} = $args{text};
        delete $args{text};
    }
   
    __PACKAGE__->SUPER::BUILDARGS( %args );
}

1;





__END__

=pod

=head1 NAME

Gapp::ProgressBar - Box widget

=head1 OBJECT HIERARCHY

    Gapp::Widget
    +--Gapp::ProgressBar

=head1 AUTHORS

Jeffrey Ray Hallock E<lt>jeffrey.hallock at gmail dot comE<gt>

=head1 COPYRIGHT & LICENSE

    Copyright (c) 2011 Jeffrey Ray Hallock.

    This program is free software; you can redistribute it and/or
    modify it under the same terms as Perl itself.

=cut