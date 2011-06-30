package Gapp::Actions::Form;

use Gapp::Actions -declare => [qw(
Cancel
Ok
Apply
)];


action Apply => (
    name => 'Apply',
    label => 'Apply',
    tooltip => 'Apply',
    icon => 'gtk-apply',
    code => sub {
        my ( $action, $widget, $userargs, $gtkw, $gtkargs ) = @_;
        my $form = $widget->form;
        $form->apply;
    }
);

action Cancel => (
    name => 'Cancel',
    label => 'Cancel',
    tooltip => 'Cancel',
    icon => 'gtk-cancel',
    code => sub {
        my ( $action, $widget, $userargs, $gtkw, $gtkargs ) = @_;
        my $form = $widget->form;
        $form->cancel;
    }
);

action Ok => (
    name => 'Ok',
    label => 'Ok',
    tooltip => 'Ok',
    icon => 'gtk-ok',
    code => sub {
        my ( $action, $widget, $userargs, $gtkw, $gtkargs ) = @_;
        my $form = $widget->form;
        $form->ok;
    }
);

1;
