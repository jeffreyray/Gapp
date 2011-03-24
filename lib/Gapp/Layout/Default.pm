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

# TreeView

build 'Gapp::TreeView', sub {
    my ( $l, $w ) = @_;
    my $gtkw = $w->gtk_widget;
    $gtkw->set_model( $w->model->gtk_widget ) if $w->model;
};

# TreeViewColumn

build 'Gapp::TreeViewColumn', sub {
    my ( $l, $w ) = @_;
    
    
    my $gtkw = $w->gtk_widget;
    
    my $gtkr = $w->renderer->gtk_widget;
    $gtkw->{renderer} = $gtkr;
    
    # add the renderer to the column
    $gtkw->pack_start( $gtkr, $w->renderer->expand ? 1 : 0 );
    
    
    # define how to display the renderer
    if ( defined $w->data_column && ! $w->data_func ) {
        $gtkw->add_attribute( $gtkr, $w->renderer->property => $w->data_column );
    }
    elsif ( $w->display ) {
        
        $gtkw->set_cell_data_func($gtkr, sub {
            
            my ( $col, $gtkrenderer, $model, $iter, @args ) = @_;
            
            local $_ = $model->get( $iter, $w->data_column ) if defined $w->data_column;
            
            my $value;
            if ( is_CodeRef( $w->data_func ) ) {
                $value = &{ $w->data_func }( @_ );
            }
            elsif ( is_Str( $w->data_func ) ) {
                my $method = $w->data_func;
                $value = $_->$method;
            }
            
            $gtkrenderer->set_property( $w->property => $value );
            
        });
    }

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

add 'Gapp::Widget', to 'Gapp::Table', sub {
    my ( $l, $w, $c ) = @_;
    
    my $cell = $c->next_cell;
    
    my $gtk_widget;
    if ( defined $cell->xalign || defined $cell->yalign ) {
        my ( $xa, $ya ) = ( $cell->xalign, $cell->yalign );
        my $xs = $xa == -1 ? 1 : 0; # x-scale
	my $ys = $ya == -1 ? 1 : 0; # y-scale
        $xa = 0 if $xa == -1; # x-align
        $ya = 0 if $ya == -1; # y-align
        
        my $gtk_align = Gtk2::Alignment->new( $xa, $ya, $xs, $ys );
        $gtk_align->add( $w->gtk_widget );
        $gtk_widget = $gtk_align;
    }
    else {
        $gtk_widget = $w->gtk_widget;
    }
    
    
    $c->gtk_widget->attach(
        $gtk_widget, $cell->table_attach, 
        0, 0
    );
    
    
    1;
};

sub add_widget_to_table {
	my $self = shift;
	my ($widget, $table) = @_;
	
	my $child_idx = $table->get_layout_data->{child_idx} || 0;

	my $table_attach = $table->get_widget_table_attach->[$child_idx];
	my $table_align  = $table->get_widget_table_align->[$child_idx];

	my $gtk_widget = $table->get_content->[$child_idx]->get_gtk_parent_widget;

	if ( defined $table_align->{xalign} or defined $table_align->{yalign} ) {
		my $xalign = $table_align->{xalign};
		my $yalign = $table_align->{yalign};

		my $xscale = $xalign == -1 ? 1 : 0;
		my $yscale = $yalign == -1 ? 1 : 0;
		
		$xalign = 0 if $xalign == -1;
		$yalign = 0 if $yalign == -1;
		
		my $gtk_align = Gtk2::Alignment->new($xalign, $yalign, $xscale, $yscale);
		$gtk_align->add($gtk_widget);
		$gtk_widget = $gtk_align;
	}


}

add 'Gapp::Widget', to 'Gapp::Window', sub {
    my ($l,  $w, $c ) = @_;
    $c->gtk_widget->add( $w->gtk_widget );
};

# Window

build 'Gapp::Window', sub {
    my ( $l, $w ) = @_;
};




1;
