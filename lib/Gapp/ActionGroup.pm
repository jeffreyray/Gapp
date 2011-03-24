package Gapp::ActionGroup;

use Moose;
use MooseX::SemiAffordanceAccessor;
use MooseX::Types::Moose qw( ArrayRef ClassName HashRef Object );

extends 'Gapp::Widget';

use Gapp::Actions::Util;

has '+class' => (
    default => 'Gtk2::ActionGroup',
);

has 'name' => (
    is => 'rw',
    isa => 'Str',
    default => '',
);

has 'actions' => (
    is => 'rw',
    isa => 'ArrayRef',
    default => sub { [ ] },
);

has 'action_args' => (
    is => 'rw',
    isa => 'ArrayRef',
    default => sub { [ ] },
);

{
    my $anon = 1;

    around BUILDARGS => sub {
        my ( $orig, $class, %opts ) = @_;
        $opts{name} ||= 'ActionGroup::__ANON__::' . $anon++;
        $opts{args} = [$opts{name}];
        $class->$orig( %opts );
    };
}

after _construct_gtk_widget => sub {
    my ( $self ) = @_;
    my $gtk_widget = $self->gtk_widget;
    
    my @actions;
    for my $a ( @{ $self->actions } ) {
        
        # if it is an array-ref/hash-ref, coerce
        if ( is_ArrayRef( $a ) || is_HashRef( $a ) ) {
            push @actions, to_GappAction( $a );
        }
        
        # if it is a Gapp::Action, apply it to the action group
        elsif ( is_Object( $a ) ) {
            push @actions, $a;
        }
        
        # if it is a class, apply all the actions to the group
        elsif ( is_ClassName ( $a ) ) {
            push @actions, ACTION_REGISTRY( $a )->actions;
        }
    }
    
    # create the gtk action widgets and add them
    # the the action group gtk widget
    map { $gtk_widget->add_action( $_->create_gtk_action( args => $self->action_args ) ) } @actions;
};

1;
