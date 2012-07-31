package Gapp::Meta::Widget::Native::Trait::MessageDialog;

use Moose::Role;
use MooseX::SemiAffordanceAccessor;
use Gapp::Types qw( GappDialogImage );

has 'image' => (
    is => 'ro',
    isa => GappDialogImage,
    default => sub {
        Gapp::Image->new(
            stock => [ 'gtk-dialog-question', 'dialog' ],
            fill => 0,
            expand => 0,
        );
    },
    trigger => sub { $_[1]->set_fill(0); $_[1]->set_expand(0); },
    coerce => 1,
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
        markup => $_[0]->summary,
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
                $self->image,
                
                Gapp::VBox->new (
                    content => [ $self->message_widget, $self->summary_widget ],
                    fill => 1,
                    expand => 1,
                )
                
            ],
            fill => 1,
            expand => 0,
        );
    },
    lazy => 1,
);

around BUILDARGS => sub {
    my ( $orig, $class, %opts ) = @_;
    $opts{buttons} ||= [ 'gtk-ok' ];
    return $class->$orig( %opts );
};

before '_build_gtk_widget' => sub {
    my ( $self ) = @_;
    $self->add( $self->hbox );
};

after '_build_gtk_widget' => sub {
    my ( $self ) = @_;
    
    $self->hbox->gtk_widget->show_all;
};

package Gapp::Meta::Widget::Custom::Trait::MessageDialog;
sub register_implementation { 'Gapp::Meta::Widget::Native::Trait::MessageDialog' };


1;