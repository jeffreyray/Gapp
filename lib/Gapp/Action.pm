package Gapp::Action;

use Moose;
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
    $self->code->( @args ) if $self->has_code;
}

sub create_gtk_action {
    my ( $self, @args ) = @_;
    my %opts = (
        name => $self->name,
        label => $self->label,
        tooltip => $self->tooltip,
        icon => $self->icon,
        @args
    );
    
    if ( $opts{icon} ) {
        $opts{'stock-id'} = $opts{icon};
    }
    
    delete $opts{icon};
    
    my $gtk_action = Gtk2::Action->new( %opts );
    $gtk_action->signal_connect( activate => sub {
        my ( $w, @args ) = @_;
        $self->perform( $self, $w, @args );
    });
    return $gtk_action;
}



no Moose;
__PACKAGE__->meta->make_immutable;

1;
