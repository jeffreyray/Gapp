package Gapp::Layout::Object;

use Moose;
use MooseX::StrictConstructor;
use MooseX::SemiAffordanceAccessor;
use MooseX::Method::Signatures;

use MooseX::Types::Moose qw( :all );

has 'parent' => (
    is => 'rw',
    isa => Object,
    weak_ref => 1,
    predicate => 'has_parent',
    clearer => 'clear_parent',
);

has '_builders' => (
    is => 'ro',
    isa => HashRef,
    default => sub { { } },
    init_arg => undef,
    traits => [qw( Hash )],
    handles => {
        add_builder => 'set',
        get_builder => 'get',
        has_builder => 'exists',
    }
);

has '_packers' => (
    is       => 'ro',
    isa      => 'HashRef[HashRef]',
    default  => sub { { } },
    init_arg => undef,
    traits   => [ 'Hash' ],
);

sub build_widget {
    my ( $self, $widget ) = @_;
    my $builder = $self->find_builder( $widget );
    return if ! defined $builder;
    
    $builder->( $self, $widget );
}

sub find_builder {
    my ( $self, $w ) = @_;
    $w = $w->meta->name if ref $w;
    $w = ($w->meta->superclasses)[0]->meta->name if $w->meta->name =~ /__ANON__/;
    return $self->get_builder( $w->meta->name ) if $self->get_builder( $w->meta->name );
    return $self->parent ? $self->parent->find_builder( $w ) : undef;
}

# the "packer" is a code ref that is called to
# add a widget to a container 
sub add_packer {
    my ( $self, $widget, $container, $code_ref ) = @_;
    $self->_packers->{$widget}{$container} = $code_ref;
}

sub has_packer {
    my ( $self, $widget, $container ) = @_;
    exists $self->_packers->{$widget}{$container};
}

sub get_packer {
    my ( $self, $widget, $container ) = @_;
    $self->_packers->{$widget}{$container};
}

# search this layout and parent layouts for a packer that will DWIM
sub find_packer {
    my ( $self, $widget, $container ) = @_;
    $widget = $widget->meta->name if ref $widget;
    $container = $container->meta->name if ref $container;
    
    # work around for dealing with classes that have traits applied
    if ( $widget->meta->name =~ /__ANON__/ ) {
        my ( $super ) = ( $widget->meta->superclasses )[0];
        $widget = $super->meta->name;
    }
    if ( $container->meta->name =~ /__ANON__/ ) {
        my ( $super ) = ( $container->meta->superclasses );
        $container = $super->meta->name;
    }
    
    # widget superclasses ( minus Moose stuff )
    my @isa = $widget->meta->linearized_isa;
    splice @isa,-2,2;
    
    for ( @isa ) {
        my $packer = $self->lookup_packer( $_, $container );
        return $packer if $packer;
    }
}

# search this layout and parent layouts for specific packer
sub lookup_packer {
    my ( $self, $widget, $container ) = @_;
    
    if ( $self->has_packer( $widget, $container ) ) {
        return $self->get_packer( $widget, $container );
    }
    else {
        return $self->parent ?
        $self->parent->lookup_packer( $widget, $container ) :
        undef;
    }
}

# pack a widget inside a container
sub pack_widget {
    my ( $self, $widget, $container ) = @_;

    my $packer = $self->find_packer( $widget , $container );
    
    # warn if cannot find packer
    if ( ! $packer ) {
        warn
            qq[could not pack ] . $widget->meta->name .
            qq[ into ] . $container->meta->name . qq[: ] .
            qq[no packer found in ]  .$self->meta->name;
        return;
    }
    
    # pack the widget
    $packer->( $self, $widget, $container );   
}



no Moose;
__PACKAGE__->meta()->make_immutable();
1;
