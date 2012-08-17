package Gapp::Gtk2;

use Gtk2;
use Gapp::Gtk2::DateEntry;
use Gapp::Gtk2::TimeEntry;
use Gapp::Gtk2::List;
use Gapp::Gtk2::List::Simple;
use Gapp::Gtk2::OComboBox;
use Gapp::Gtk2::SSNEntry;

1;


__END__

=pod

=head1 NAME

Gapp::Gtk2 - Gtk2 Widget Extension

=head1 SYNOPSIS

  use Gtk2 '-init';

  use Gapp::Gtk2;

  $list = Gapp::Gtk2::List::Simple->new;
  $list->append( $anything );
  
   
=head1 DESCRIPTION

Gapp comes with some additional Gtk2 widgets as well. You can use them
without the Gapp layer by using L<Gapp::Gtk2>.

=head1 AUTHOR

Jeffrey Ray Hallock E<lt>jeffrey.hallock at gmail dot comE<gt>

=head1 COPYRIGHT

    Copyright (c) 2011-2012 Jeffrey Ray Hallock.
    This program is free software; you can redistribute it and/or
    modify it under the same terms as Perl itself.

=cut

