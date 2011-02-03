package Gapp::Meta::TreeViewColumn;

use Moose;
use MooseX::SemiAffordanceAccessor;
use MooseX::StrictConstructor;
use MooseX::Method::Signatures;

use MooseX::Types::Moose qw( ClassName CodeRef Int Str Undef );

use Gtk2;

has 'class' => (
    is => 'rw',
    isa => ClassName,
    default => 'Gtk2::TreeViewColumn',
);

has 'name' => (
    is => 'rw',
    isa => Str,
    default => '',
);

has 'label' => (
    is => 'rw',
    isa => Str,
    default => '',
);

has 'renderer_class' => (
    is => 'rw',
    isa => Str,
    default => 'Gtk2::CellRendererText',
);

has 'build_renderer' => (
    is => 'rw',
    isa => CodeRef|Undef,
);

has 'display' => (
    is => 'rw',
    isa => Str|CodeRef|Undef,
);

has 'property' => (
    is => 'rw',
    isa => Str,
    default => 'markup',
);

has 'data_column' => (
    is => 'rw',
    isa => Int|Undef,
    default => undef,
);

sub gtk_widget  {
    my ( $self ) = @_;
    
    my $r = $self->gtk_renderer;
    
    my $w = $self->class->new_with_attributes( $self->label, $r );
    
    $w->{renderer} = $r;
    
    if ( defined $self->data_column && ! $self->display ) {
        
        $w->add_attribute( $r, $self->property => $self->data_column );
        
    }
    elsif ( $self->display ) {
        
        $w->set_cell_data_func($r, sub {
            
            my ( $col, $renderer, $model, $iter, @args ) = @_;
            
            local $_ = $model->get( $iter, $self->data_column ) if defined $self->data_column;
            
            my $value;
            if ( is_CodeRef( $self->display ) ) {
                $value = &{ $self->display }( @_ );
            }
            elsif ( is_Str( $self->display ) ) {
                my $method = $self->display;
                $value = $_->$method;
            }
            
            $renderer->set_property( $self->property => $value );
            
        });
        
    }
    
    return $w;
}

sub gtk_renderer {
    my ( $self ) = @_;
    
    $self->build_renderer ?
    $self->build_renderer->() :
    $self->renderer_class->new;
}

no Moose;
__PACKAGE__->meta->make_immutable;

1;
