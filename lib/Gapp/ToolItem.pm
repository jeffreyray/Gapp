package Gapp::ToolItem;

use Moose;
use MooseX::SemiAffordanceAccessor;
extends 'Gapp::Widget';

has '+class' => (
    default => 'Gtk2::ToolItem',
);

has 'action' => (
    is => 'rw',
    isa => 'Maybe[Gapp::Action]',
);


1;



__END__

=pod

=head1 NAME

Gapp::ToolItem - ToolItem Widget

=head1 OBJECT HIERARCHY

=over 4

=item L<Gapp::Widget>

=item ....+-- L<Gapp::ToolItem>

=back

=head1 PROVIDED ATTRIBUTES

=over 4

=item B<action>

=over 4

=item isa GappAction|Undef

=back

=back

=head1 AUTHORS

Jeffrey Ray Hallock E<lt>jeffrey.hallock at gmail dot comE<gt>

=head1 COPYRIGHT & LICENSE

    Copyright (c) 2011 Jeffrey Ray Hallock.

    This program is free software; you can redistribute it and/or
    modify it under the same terms as Perl itself.

=cut