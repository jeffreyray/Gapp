package Gapp::Meta::GtkAssistantPage;

use Moose;
use MooseX::SemiAffordanceAccessor;
use MooseX::StrictConstructor;

use MooseX::Types::Moose qw( ClassName CodeRef Int Str Undef );

use Gtk2;

has 'widget' => (
    is => 'rw',
    isa => ClassName|CodeRef,
    default => 'Gtk2::VBox',
);

has 'name' => (
    is => 'rw',
    isa => Str,
    default => '',
);

has 'title' => (
    is => 'rw',
    isa => Str,
    default => '',
);

has 'type' => (
    is => 'rw',
    isa => Str,
    default => '',
);

has 'icon' => (
    is => 'rw',
    isa => Str,
    default => '',
);

has 'build' => (
    is => 'rw',
    isa => CodeRef|Undef,
);

sub gobject  {
    my ( $self, $gappw, $assistant ) = @_;
    
    my $w = is_ClassName($self->widget) ?
    $self->widget->new :
    $self->widget->( $self );
    
    $self->build->( $gappw, $assistant, $w ) if $self->build;    
    return $w;
}

sub append_to {
    my ( $page, $gappw, $assistant ) = @_;
    my $gobject = $page->gobject( $gappw, $assistant );
    my $page_num = $assistant->append_page( $gobject );
    $gobject->{pagenum} = $page_num;
    $assistant->set_page_title     ($gobject, $page->title );
    $assistant->set_page_side_image($gobject, $assistant->render_icon( $page->icon , 'dnd' ) );
    $assistant->set_page_type      ($gobject, $page->type );
    $assistant->set_page_complete  ($gobject, 1);
    $assistant->{pages}{$page->name} = $gobject;  
}

1;
