package Gapp::Layout::Default;
use Gapp::Layout;
use strict;
use warnings;

# Assistant

build 'Gapp::Assistant', sub {
    my ( $l, $w ) = @_;
};


# Assistnat Page

build 'Gapp::AssistantPage', sub {
    my ( $l, $w ) = @_;
};

add 'Gapp::AssistantPage', to 'Gapp::Assistant', sub {
   my ( $l, $w, $c) = @_;
   
    my $gtk_w = $w->gtk_widget;
    my $assistant = $c->gtk_widget;
   
    my $page_num = $assistant->append_page( $gtk_w );
    $gtk_w->{pagenum} = $page_num;
    $assistant->set_page_title     ($gtk_w, $w->title );
    $assistant->set_page_side_image($gtk_w, $assistant->render_icon( $w->icon , 'dnd' ) ) if $w->icon;
    $assistant->set_page_type      ($gtk_w, $w->type );
    $assistant->set_page_complete  ($gtk_w, 1);
    $assistant->{pages}{$w->name} = $gtk_w;  
};


# Dialog

build 'Gapp::Dialog', sub {
    my ( $l, $w ) = @_;
    my $gtk_w = $w->gtk_widget;
    
    my $i = 0; for my $b ( @{ $w->buttons } ) {
        $gtk_w->add_button( $b, $i );
        $i++;
    }
};

# Label

build 'Gapp::Label', sub {
    my ( $l, $w ) = @_;

    my $gtkw = $w->gtk_widget;
    $gtkw->set_text( $w->text ) if defined $w->text;
    $gtkw->set_markup( $w->markup ) if defined $w->markup;
};

# Image

build 'Gapp::Image', sub {
    my ( $l, $w ) = @_;
    
    my $gtkw = $w->gtk_widget;
    if ( $w->stock ) {
        $gtkw->set_from_stock( $w->stock->[0], $w->stock->[1] );
    }
};

# ImageMenuItem

build 'Gapp::ImageMenuItem', sub {
    my ( $l, $w ) = @_;
    my $gtkw = $w->gtk_widget;
    $gtkw->get_child->set_text( $w->label ) if $w->label;
    $gtkw->set_image( Gtk2::Image->new_from_stock( $w->icon, 'menu' ) ) if $w->icon;
};

add 'Gapp::MenuItem', to 'Gapp::Menu', sub {
    my ( $l, $w, $c ) = @_;
    $c->gtk_widget->append( $w->gtk_widget );
};


# MenuItem

build 'Gapp::MenuItem', sub {
    my ( $l, $w ) = @_;
    $w->gtk_widget->get_child->set_text( $w->label ) if $w->label;
};

add 'Gapp::MenuItem', to 'Gapp::MenuShell', sub {
    my ( $l, $w, $c ) = @_;
    $c->gtk_widget->append( $w->gtk_widget );
};

# Toolbar
build 'Gapp::Toolbar', sub {
    my ( $l, $w ) = @_;
    $w->gtk_widget->set_icon_size( $w->icon_size ) if $w->icon_size;
};

# ToolItem

add 'Gapp::ToolItem', to 'Gapp::Toolbar', sub {
    my ($l,  $w, $c) = @_;
    $c->gtk_widget->insert( $w->gtk_widget, -1 );
};


# ToolButton

build 'Gapp::ToolButton', sub {
    my ( $l, $w ) = @_;
    my $gtkw = $w->gtk_widget;
    $gtkw->set_stock_id( $w->stock_id ) if $w->stock_id;
    $gtkw->set_label( $w->label ) if defined $w->label;
    $gtkw->set_icon_widget( Gtk2::Image->new_from_stock( $w->icon, 'dnd' ) ) if $w->icon;
};

# Widget

add 'Gapp::Widget', to 'Gapp::AssistantPage', sub {
    my ($l,  $w, $c ) = @_;
    $c->gtk_widget->pack_start( $w->gtk_widget, $w->expand, $w->fill, $w->padding );
};

add 'Gapp::Widget', to 'Gapp::Container', sub {
    my ($l,  $w, $c) = @_;
    $c->gtk_widget->pack_start( $w->gtk_widget, $w->expand, $w->fill, $w->padding );
};

add 'Gapp::Widget', to 'Gapp::HBox', sub {
    my ($l,  $w, $c ) = @_;
    $c->gtk_widget->pack_start( $w->gtk_widget, $w->expand, $w->fill, $w->padding );
};

add 'Gapp::Widget', to 'Gapp::VBox', sub {
    my ($l,  $w, $c ) = @_;
    $c->gtk_widget->pack_start( $w->gtk_widget, $w->expand, $w->fill, $w->padding );
};

add 'Gapp::Widget', to 'Gapp::Dialog', sub {
    my ($l,  $w, $c ) = @_;
    $c->gtk_widget->vbox->pack_start( $w->gtk_widget, $w->expand, $w->fill, $w->padding );
    $w->gtk_widget->show;
};

add 'Gapp::Widget', to 'Gapp::Window', sub {
    my ($l,  $w, $c ) = @_;
    $c->gtk_widget->add( $w->gtk_widget );
};

# Window

build 'Gapp::Window', sub {
    my ( $l, $w ) = @_;
};




1;
