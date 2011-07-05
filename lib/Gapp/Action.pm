package Gapp::Action;

use Moose;
use MooseX::Clone;
use MooseX::SemiAffordanceAccessor;
use MooseX::StrictConstructor;
use MooseX::Method::Signatures;

use MooseX::Types::Moose qw( CodeRef HashRef Object Str  );

has [qw( label name)] => (
    is => 'rw',
    isa => Str,
    default => '',
);

has 'tooltip' => (
    is => 'rw',
    isa => Str,
    clearer => 'clear_tooltip',
    predicate => 'has_tooltip',
);

has 'icon' => (
    is => 'rw',
    isa => Str,
    clearer => 'clear_icon',
    predicate => 'has_icon',
);

has 'code' => (
    is => 'rw',
    isa => CodeRef,
    clearer => 'clear_code',
    predicate => 'has_code',
);


sub perform {
    my ( $self, @args ) = @_;
    return $self->code->( $self, @args ) if $self->has_code;
}

sub create_gtk_action {
    my ( $self, @args ) = @_;
    my %opts = (
        name => $self->name,
        label => $self->label,
        tooltip => $self->tooltip,
        icon => $self->icon,
        args => [],
        @args
    );
    
    if ( $opts{icon} ) {
        $opts{'stock-id'} = $opts{icon};
    }
    
    delete $opts{icon};
    my $args = delete $opts{args};
    
    my $gtk_action = Gtk2::Action->new( %opts );
    $gtk_action->signal_connect( activate => sub {
        my ( $w, @gtkargs ) = @_;
        $self->perform( $self, $args, $w, \@gtkargs );
    });
    return $gtk_action;
}

sub create_gapp_image {
    my ( $self, @args ) = @_;
    Gapp::Image->new( gtk_widget => Gtk2::Image->new_from_stock( $self->icon , $args[0] ) );
}

sub create_gtk_image {
    my ( $self, @args ) = @_;
    Gtk2::Image->new_from_stock( $self->icon , $args[0] );
}



no Moose;
__PACKAGE__->meta->make_immutable;

1;
