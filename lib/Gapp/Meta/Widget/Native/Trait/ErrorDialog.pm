package Gapp::Meta::Widget::Native::Trait::ErrorDialog;

use Moose::Role;
use MooseX::SemiAffordanceAccessor;

has 'icon' => (
    is => 'ro',
    default => sub {
        Gapp::Image->new(
            stock => [ 'gtk-dialog-error', 'dialog' ],
        );
    },
    lazy => 1,
);

has 'message_widget' => (
    is => 'ro',
    isa => 'Gapp::Widget',
    lazy_build => 1,
);

sub _build_message_widget {
    Gapp::Label->new(
        markup => '<b>' . $_[0]->message . '</b>',
        fill => 0,
        expand => 0,
        properties => { xalign => 0 }
    );
};

has 'summary_widget' => (
    is => 'ro',
    isa => 'Gapp::Widget',
    lazy_build => 1,
);

sub _build_summary_widget {
    Gapp::Label->new(
        markup => '<b>' . $_[0]->summary . '</b>',
        fill => 0,
        expand => 0,
        properties => { xalign => 0 }
    );
};

has 'message' => (
    is => 'rw',
    isa => 'Str',
    default => '',
);

has 'summary' => (
    is => 'rw',
    isa => 'Str',
    default => '',
);

has 'hbox' => (
    is => 'ro',
    default => sub {
        my $self = shift;
        Gapp::HBox->new(
            content => [
                $self->icon,
                
                Gapp::VBox->new (
                    content => [ $self->message_widget, $self->summary_widget ],
                )
                
            ],
            fill => 0,
            expand => 0,
        );
    },
    lazy => 1,
);

around BUILDARGS => sub {
    my ( $orig, $class, %opts ) = @_;
    $opts{buttons} = [ 'gtk-ok' ];
    return $class->$orig( %opts );
};

after '_build_gtk_widget' => sub {
    my ( $self ) = @_;
    $self->add( $self->hbox );
    $self->hbox->gtk_widget->show_all;
};

package Gapp::Meta::Widget::Custom::Trait::ErrorDialog;
sub register_implementation { 'Gapp::Meta::Widget::Native::Trait::ErrorDialog' };


1;