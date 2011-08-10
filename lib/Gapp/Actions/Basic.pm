package Gapp::Actions::Basic;

use Gapp::Actions -declare => [qw(
DestroyWindow
Quit
)];


use Gtk2;

action DestroyWindow => (
    name => 'Close',
    label => 'Close',
    tooltip => 'Close',
    icon => 'gtk-cancel',
    code => sub {
        my ( $widget, $args, $gtkw, $gtkargs ) = @_;
        $gtkw->destroy;
    }
);

action Quit => (
    name => 'Quit',
    label => 'Quit',
    tooltip => 'Quit',
    icon => 'gtk-quit',
    code => sub {
        Gtk2->main_quit;
    }
);



1;
