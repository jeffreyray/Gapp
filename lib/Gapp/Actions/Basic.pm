package Gapp::Actions::Basic;

use Gapp::Actions -declare => [qw(
Quit
)];


use Gtk2;

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
