package Gapp::Layout::Default;
use Gapp::Layout;
use strict;
use warnings;

use Gapp::Util qw( replace_entities );
use Gapp::Actions::Util qw( actioncb parse_action);
use Gapp::Types qw( GappAction GappActionOrArrayRef );
use MooseX::Types::Moose qw( ArrayRef CodeRef Str );

use Carp qw( confess );

# Assistant

build 'Gapp::Assistant', sub {
    my ( $l, $w ) = @_;
    $w->gobject->set_icon( $w->gobject->render_icon( $w->icon, 'dnd' ) ) if $w->icon;
    
    if ( $w->forward_page_func ) {
	
	my ( $cb, @args ) = parse_action $w->forward_page_func;
	
	$w->gobject->set_forward_page_func( sub {
	    my ( $pagenum, $w ) = @_;
	    $cb->( $w, \@args, $w->gobject, [$pagenum] );
	}, $w);
    }
};


# Assistnat Page

build 'Gapp::AssistantPage', sub {
    my ( $l, $w ) = @_;
};

add 'Gapp::AssistantPage', to 'Gapp::Assistant', sub {
   my ( $l, $w, $c) = @_;
   
    my $gtk_w = $w->gobject;
    my $assistant = $c->gobject;
   
    my $page_num = $assistant->append_page( $gtk_w );
    $w->set_num( $page_num );
    $assistant->set_page_title     ($gtk_w, $w->title );
    $assistant->set_page_side_image($gtk_w, $assistant->render_icon( $w->icon , 'dnd' ) ) if $w->icon;
    $assistant->set_page_type      ($gtk_w, $w->type );
    $assistant->set_page_complete  ($gtk_w, 1);
    $assistant->{pages}{$w->name} = $gtk_w;  
};

build 'Gapp::Button', sub {
    my ( $l, $w ) = @_;
    my $gtkw = $w->gobject;
    
    my ( $label, $image, $tooltip );
    
    if ( $w->icon ) {
	$image = Gtk2::Image->new_from_stock( $w->icon, 'button' );
    }
    if ( $w->image ) {
	$image = $w->image->gobject;
    }
    
    if ( $w->action ) {
	my ( $action, @args );
	
	if ( is_ArrayRef( $w->action ) ) {
	    ( $action, @args ) = @{ $w->action };
	}
	else {
	    $action = $w->action;
	}
	
        $label = defined $w->label ? $w->label : $action->label;
	$image ||= $action->create_gtk_image( 'button' );
	
	
	if ( is_CodeRef( $action ) ) {
	    $tooltip = $w->tooltip;
	    $label = $w->label;
	    
	    $w->signal_connect( 'clicked', $action, @args );
	}
	else {
	    $tooltip = defined $w->tooltip ? $w->tooltip : $action->tooltip;
	    
	    $gtkw->signal_connect( clicked => sub {
		my ( $gtkw, @gtkargs ) = @_;
		$action->perform( $w, \@args, $gtkw, \@gtkargs );
	    });
	}
    }
    else {
	$label = $w->label;
	$tooltip = $w->tooltip;
    }
    
    $gtkw->set_label( $label ) if defined $label;
    $gtkw->set_image( $image ) if defined $image;
    $gtkw->set_tooltip_text( $tooltip ) if defined $tooltip;
};

# ComboBox

build 'Gapp::ComboBox', sub {
    my ( $l, $w ) = @_;
    my $gtkw = $w->gobject;
    
    my $model = $w->model->isa('Gapp::Widget') ? $w->model->gobject : $w->model;
    
    # populate the module with values
    if ( $w->values ) {
        
        my $model = $w->model->isa('Gapp::Widget') ? $w->model->gobject : $w->model;
        
        my @values = is_CodeRef($w->values) ? &{$w->values}($w) : @{$w->values};
        $model->append( $_ ) for ( @values );
        
    }
    
    $gtkw->set_model( $model );
    
    # create the renderer to display the values
    my $gtkr = $w->renderer->gobject;
    $gtkw->{renderer} = $gtkr;
    
    # add the renderer to the column
    $gtkw->pack_start( $gtkr, $w->renderer->expand ? 1 : 0 );
    
    
    # define how to display the renderer
    if ( defined $w->data_column && ! $w->data_func ) {
        $gtkw->set_cell_data_func($gtkr, sub {
            
            my ( $col, $gtkrenderer, $model, $iter, @args ) = @_;
            
            my $value = $model->get( $iter ) if defined $w->data_column;
            
            $gtkrenderer->set_property( 'markup' => defined $value ? replace_entities( $value ) : '' );
        });
    }
    elsif ( $w->data_func ) {
        
        $gtkw->set_cell_data_func($gtkr, sub {
            
            my ( $col, $gtkrenderer, $model, $iter, @args ) = @_;

            my $value = $model->get( $iter ) if defined $w->data_column;
            local $_ = $value;
            
            if ( is_CodeRef( $w->data_func ) ) {
                $value = &{ $w->data_func }( $_ );
            }
            elsif ( is_Str( $w->data_func ) ) {
                my $method = $w->data_func;
                $value = defined $_ ? $_->$method : '';
            }

            $gtkrenderer->set_property( 'markup' => defined $value ? replace_entities( $value ) : '' );
            
        });
    }

};

# Dialog

build 'Gapp::Dialog', sub {
    my ( $l, $w ) = @_;
    my $gtk_w = $w->gobject;
    $w->gobject->set_icon( $w->gobject->render_icon( $w->icon, 'dnd' ) ) if $w->icon;
    $w->gobject->set_position( $w->position ) if $w->position;
    $w->gobject->set_transient_for( $w->transient_for->gobject ) if $w->transient_for;
    
    my $i = 0;
    if ( $w->action_widgets ) {
	for my $b ( @{ $w->action_widgets } ) {
	    $gtk_w->add_action_widget( $b->gobject, $i );
	    $i++;
	}
    }
    if ( $w->buttons ) {
	for my $b ( @{ $w->buttons } ) {
	    $gtk_w->add_button( $b, $i );
	    $i++;
	}
    }
};

# FileChooserDialog

build 'Gapp::FileChooserDialog', sub {
    my ( $l, $w ) = @_;
    my $gtk_w = $w->gobject;
    $w->gobject->set_icon( $w->gobject->render_icon( $w->icon, 'dnd' ) ) if $w->icon;
    $w->gobject->set_position( $w->position ) if $w->position;
    $w->gobject->set_transient_for( $w->transient_for->gobject ) if $w->transient_for;
    
    if ( $w->buttons ) {
	my $i = 0; for my $b ( @{ $w->buttons } ) {
	    $gtk_w->add_button( $b, $i );
	    $i++;
	}
    }
    

    
    map { $w->gobject->add_filter( $_->gobject ) } $w->filters;
};

# FileFilter

build 'Gapp::FileFilter', sub {
    my ( $l, $w ) = @_;
    
    my $gtkw = $w->gobject;
    $gtkw->set_name( $w->name );
    map { $gtkw->add_pattern( $_ ) } $w->patterns;
    map { $gtkw->add_mime_type( $_ ) } $w->mime_types; 
};


# Label

build 'Gapp::Label', sub {
    my ( $l, $w ) = @_;

    my $gtkw = $w->gobject;
    #$gtkw->set_text( $w->text ) if defined $w->text;
    #$gtkw->set_markup( $w->markup ) if defined $w->markup;
};

# Image

build 'Gapp::Image', sub {
    my ( $l, $w ) = @_;
    
    my $gtkw = $w->gobject;
    if ( $w->stock ) {
        $gtkw->set_from_stock( $w->stock->[0], $w->stock->[1] );
    }
};

# ImageMenuItem

build 'Gapp::ImageMenuItem', sub {
    my ( $l, $w ) = @_;
    my $gtkw = $w->gobject;
    
    my ( $label, $icon, $tooltip );
    $label = $w->label;
    $icon = $w->icon;
    $tooltip = $w->tooltip;
    
    my ( $action, @args ) = parse_action( $w->action );
    
    if ( is_CodeRef($action) ) {
	$gtkw->signal_connect( 'activate', $action, \@args );
    }
    elsif ( is_GappAction( $action) ) {
	$icon = $action->icon if ! defined $icon;
	$label = $action->label if ! defined $label;
	$tooltip = $action->tooltip if ! defined $tooltip;
	$gtkw->signal_connect( activate => actioncb( $action, $w, \@args ) );
    }
    
    $gtkw->get_child->set_text( $label ) if defined $label;
    $gtkw->set_tooltip_text( $w->tooltip ) if defined $w->tooltip;
    $gtkw->set_image( Gtk2::Image->new_from_stock( $icon, 'menu' ) ) if defined $icon;
    
    if ( $w->menu ) {
	$gtkw->set_submenu( $w->menu->gobject );
    }
};

add 'Gapp::MenuItem', to 'Gapp::Menu', sub {
    my ( $l, $w, $c ) = @_;
    $c->gobject->append( $w->gobject );
    $c->gobject->show;
};






# MenuItem
build 'Gapp::MenuItem', sub {
    my ( $l, $w ) = @_;
    
    my $gtkw = $w->gobject;
    if ( $w->menu ) {
	$gtkw->set_submenu( $w->menu->gobject );
    }
    
    $w->gobject->get_child->set_text( $w->label ) if $w->label;
};

add 'Gapp::MenuItem', to 'Gapp::MenuShell', sub {
    my ( $l, $w, $c ) = @_;
    $c->gobject->append( $w->gobject );
    $c->gobject->show;
};


# ToolButton

build 'Gapp::MenuToolButton', sub {
    my ( $l, $w ) = @_;
    my $gtkw = $w->gobject;
    
    $gtkw->set_stock_id( $w->stock_id ) if $w->stock_id;
    $gtkw->set_label( $w->label ) if defined $w->label;
    $gtkw->set_tooltip_text( $w->tooltip ) if defined $w->tooltip;
    
    my $action = is_ArrayRef( $w->action ) ? $w->action->[0] : $w->action;
    my ( $cb, @args );
    @args = is_ArrayRef( $w->action ) ? @{$w->action} : ();
    shift @args;
    
    if ( is_CodeRef($action) ) {
	$cb = $action;
	$gtkw->signal_connect( 'clicked', $cb, \@args );
    }
    elsif ( is_GappAction( $action) ) {
	$gtkw->set_stock_id( $action->icon ) if $action->icon;
	$gtkw->set_label( $action->label ) if $action->label;
	$gtkw->set_tooltip_text( $action->tooltip ) if defined $action->tooltip;
	
	$gtkw->signal_connect( clicked => actioncb( $action, $w, \@args ) );
    }
    
    $w->menu->gobject->show_all;
    $w->gobject->set_menu( $w->menu->gobject ) if $w->menu;
};


# Notice
build 'Gapp::Notebook', sub {
    my ( $l, $w ) = @_;

    my $gtkw = $w->gobject;
    
};


add 'Gapp::Widget', to 'Gapp::Notebook', sub {
    my ( $l, $w, $c) = @_;
   
    my $gtkw = $w->gobject;
    
    # check that widget is a NotebookPage
    if ( ! $w->does('Gapp::Meta::Widget::Native::Trait::NotebookPage') ) {
	die qq[ Could not add $w to $c, $w must have the NotebookPage trait applied.];
    }
    
    my $gtknb = $c->gobject;
    
    $gtknb->append_page( $gtkw );
    
    $c->{pages}{$w->page_name} = $w;
};




# Notice
build 'Gapp::Notice', sub {
    my ( $l, $w ) = @_;

    my $gtkw = $w->gobject;
    
};



# NoticeBox
style 'Gapp::NoticeBox', sub {
    my ( $l, $w ) = @_;
    
    $w->properties->{decorated} ||= 0;
    $w->properties->{opacity}   ||= 0;
    $w->properties->{gravity}   ||= 'south-east';
    $w->properties->{'skip-taskbar-hint'} = 1;
};

build 'Gapp::NoticeBox', sub {
    my ( $l, $w ) = @_;

    my $gtkw = $w->gobject;
    $gtkw->set_keep_above( 1 );
};

# SimpleList
build 'Gapp::SimpleList', sub {
    my ( $l, $w ) = @_;
    map { $w->gobject->append( $_ ) } @{ $w->content };
};


# SpinButton
build 'Gapp::SpinButton', sub {
    my ( $l, $w ) = @_;
    $w->gobject->set_increments( $w->step, $w->page ) if $w->page;
};




# ScrolledWindow
build 'Gapp::ScrolledWindow', sub {
    my ( $l, $w ) = @_;
    $w->gobject->set_policy( @{ $w->policy }) if $w->policy;
};

add 'Gapp::Widget', to 'Gapp::ScrolledWindow', sub {
    my ($l, $w, $c) = @_;
    
    if ( $c->use_viewport ) {
	$c->gobject->add_with_viewport( $w->gobject );
    }
    else {
	$c->gobject->add( $w->gobject );
    }
    
};


# TextBuffer
build 'Gapp::TextView', sub {
    my ( $l, $w ) = @_;
    $w->gobject->set_buffer( $w->buffer->gobject ) if $w->buffer;
};



# TextView
build 'Gapp::TextView', sub {
    my ( $l, $w ) = @_;
    $w->gobject->set_buffer( $w->buffer->gobject ) if $w->buffer;
};


# Toolbar
build 'Gapp::Toolbar', sub {
    my ( $l, $w ) = @_;
    $w->gobject->set_icon_size( $w->icon_size ) if $w->icon_size;
};

# ToolItem

add 'Gapp::ToolItem', to 'Gapp::Toolbar', sub {
    my ($l,  $w, $c) = @_;
    $c->gobject->insert( $w->gobject, -1 );
};


# ToolButton

build 'Gapp::ToolButton', sub {
    my ( $l, $w ) = @_;
    my $gtkw = $w->gobject;
    
    $gtkw->set_stock_id( $w->stock_id ) if $w->stock_id;
    $gtkw->set_label( $w->label ) if defined $w->label;
    $gtkw->set_tooltip_text( $w->tooltip ) if defined $w->tooltip;
    
    
    if ( $w->action ) {
	my $action = is_ArrayRef( $w->action ) ? $w->action->[0] : $w->action;
	my ( $cb, @args );
	@args = is_ArrayRef( $w->action ) ? @{$w->action} : ();
	shift @args;
	
	if ( is_CodeRef($action) ) {
	    $cb = $action;
	    $gtkw->signal_connect( 'clicked', $cb, @args );
	}
	else {
	    $gtkw->set_stock_id( $action->icon ) if $action->icon;
	    $gtkw->set_label( $action->label ) if $action->label;
	    $gtkw->set_tooltip_text( $action->tooltip ) if defined $action->tooltip;
	    
	    $gtkw->signal_connect( clicked => sub {
		my ( $gtkw, @gtkargs ) = @_;
		$action->perform( $w, \@args, $gtkw, \@gtkargs );
	    });
	}
    }
};

# TreeView

build 'Gapp::TreeView', sub {
    my ( $l, $w ) = @_;
    my $gtkw = $w->gobject;
    $gtkw->set_model( $w->model->isa('Gapp::Widget') ? $w->model->gobject : $w->model ) if $w->model;
};

# TreeViewColumn

build 'Gapp::TreeViewColumn', sub {
    my ( $l, $w ) = @_;
    
    my $gtkw = $w->gobject;
    
    my $gtkr = $w->renderer->gobject;
    $gtkw->{renderer} = $gtkr;
    
    # add the renderer to the column
    $gtkw->pack_start( $gtkr, $w->renderer->expand ? 1 : 0 );
    
    
    # define how to display the renderer
    if ( defined $w->data_column && ! $w->data_func ) {
        $gtkw->add_attribute( $gtkr, $w->renderer->property => $w->data_column );
    }
    elsif ( $w->data_func ) {
        $gtkw->set_cell_data_func($gtkr, sub {
            my ( $col, $gtkrenderer, $model, $iter, @args ) = @_;
	    my $value = $w->get_cell_value( $model->get( $iter, $w->data_column ) );
            $gtkrenderer->set_property( $w->renderer->property => $value );
        });
    }
    
    # if sorting enabled
    if ( $w->sort_enabled ) {
	$w->gobject->set_clickable( 1 );
	$w->gobject->signal_connect( 'clicked', sub {
	    $w->gobject->get_tree_view->get_model->set_default_sort_func( sub {
		my ( $model, $itera, $iterb, $w ) = @_;
		my $a = $model->get( $itera, $w->data_column );
		my $b = $model->get( $iterb, $w->data_column );
		$w->sort_func->( $w, $a, $b );
	    }, $w)
	} );
    }

};

# Widget

add 'Gapp::Widget', to 'Gapp::AssistantPage', sub {
    my ($l,  $w, $c ) = @_;
    $c->gobject->pack_start( $w->gobject, $w->expand, $w->fill, $w->padding );
};

add 'Gapp::Widget', to 'Gapp::Bin', sub {
    my ($l,  $w, $c ) = @_;
    $c->gobject->add( $w->gobject );
};

add 'Gapp::Widget', to 'Gapp::Container', sub {
    my ($l,  $w, $c) = @_;
    $c->gobject->pack_start( $w->gobject, $w->expand, $w->fill, $w->padding );
};

add 'Gapp::Widget', to 'Gapp::HBox', sub {
    my ($l,  $w, $c ) = @_;
    $c->gobject->pack_start( $w->gobject, $w->expand, $w->fill, $w->padding );
};

add 'Gapp::Widget', to 'Gapp::VBox', sub {
    my ($l,  $w, $c ) = @_;
    $c->gobject->pack_start( $w->gobject, $w->expand, $w->fill, $w->padding );
};

add 'Gapp::Widget', to 'Gapp::Paned', sub {
    my ($l,  $w, $c ) = @_;
    
    if ( ! $c->gobject->get_child1 ) {
	$c->gobject->pack1( $w->gobject, $c->resize1, $c->shrink1 );
    }
    else {
	$c->gobject->pack2( $w->gobject, $c->resize2, $c->shrink2 );
    }
};

add 'Gapp::Widget', to 'Gapp::Dialog', sub {
    my ($l,  $w, $c ) = @_;
    $c->gobject->vbox->pack_start( $w->gobject, $w->expand, $w->fill, $w->padding );
    $w->gobject->show;
};

add 'Gapp::Widget', to 'Gapp::Table', sub {
    my ( $l, $w, $c ) = @_;
    
    my $cell = $c->next_cell;
    
    my $gobject;
    if ( defined $cell->xalign || defined $cell->yalign ) {
        my ( $xa, $ya ) = ( $cell->xalign, $cell->yalign );
        my $xs = $xa == -1 ? 1 : 0; # x-scale
	my $ys = $ya == -1 ? 1 : 0; # y-scale
        $xa = 0 if $xa == -1; # x-align
        $ya = 0 if $ya == -1; # y-align
        
        my $gtk_align = Gtk2::Alignment->new( $xa, $ya, $xs, $ys );
        $gtk_align->add( $w->gobject );
        $gobject = $gtk_align;
    }
    else {
        $gobject = $w->gobject;
    }
    
    
    $c->gobject->attach(
        $gobject, $cell->table_attach, 
        0, 0
    );
    
    
    1;
};

add 'Gapp::Widget', to 'Gapp::ToolItemGroup', sub {
    my ($l,  $w, $c ) = @_;
    $c->gobject->add( $w->gobject );
};

add 'Gapp::Widget', to 'Gapp::ToolPalette', sub {
    my ($l,  $w, $c ) = @_;
    $c->gobject->add( $w->gobject );
};

add 'Gapp::Widget', to 'Gapp::Window', sub {
    my ($l,  $w, $c ) = @_;
    $c->gobject->add( $w->gobject );
};

# Window

build 'Gapp::Window', sub {
    my ( $l, $w ) = @_;
    $w->gobject->set_icon( $w->gobject->render_icon( $w->icon, 'dnd' ) ) if $w->icon;
    $w->gobject->set_transient_for( $w->transient_for->gobject ) if $w->transient_for;
    $w->gobject->set_modal( $w->modal ) if $w->modal;
    $w->gobject->set_position( $w->position ) if $w->position;
};




1;
