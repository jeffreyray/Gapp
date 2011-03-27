package Gapp::Types;

use MooseX::Types -declare => [qw(
Form
FormContext
FormField
FormStash
GappAction
GappCellRenderer
GappContainer
GappLayout
GappTableMap
GappTreeViewColumn
GappUIManager
GappWidget
)];

use MooseX::Types::Moose qw( ArrayRef ClassName CodeRef HashRef Int Str );

# GappContainer
class_type GappContainer,
    { class => 'Gapp::Container' };

# GappWidget
class_type GappWidget,
    { class => 'Gapp::Widget' };

# FormField
type Form,
    as GappContainer,
    where { $_->does('Gapp::Meta::Widget::Native::Trait::Form') };

# FormField
subtype FormField,
    as GappWidget,
    where { $_->does('Gapp::Meta::Widget::Native::Trait::FormField') };

# FormContext
class_type FormContext,
    { class => 'Gapp::Form::Context' };
    
# FormContext
class_type FormStash,
    { class => 'Gapp::Form::Stash' };


# GappAction
class_type GappAction,
    { class => 'Gapp::Action' };

# GappCellRenderer
class_type GappCellRenderer,
    { class => 'Gapp::CellRenderer' };


    my %RENDERERS = (
        'text'   => [ 'Gtk2::CellRendererText', 'text' ],
        'markup' => [ 'Gtk2::CellRendererText', 'markup' ],
        'toggle' => [ 'Gtk2::CellRendererToggle', 'active' ],
    );

    coerce GappCellRenderer,
        from Str,
        via {
            if ( exists $RENDERERS{ $_ } ) {
                my ( $c, $p ) = ( @{ $RENDERERS{ $_ } } );
                'Gapp::CellRenderer'->new( class => $c, property => $p );
            }
        };
    
    coerce GappCellRenderer,
        from HashRef,
        via { 'Gapp::CellRenderer'->new( %$_ ) };
    
    coerce GappCellRenderer,
        from ArrayRef,
        via { 'Gapp::CellRenderer'->new( class => $_->[0], property => $_->[1] ) };


# GappTableMap
class_type GappLayout,
    { class => 'Gapp::Layout::Object' };
    
coerce GappLayout,
    from Str,
    via { $_->Layout };

# GappTableMap
class_type GappTableMap,
    { class => 'Gapp::TableMap' };
    
coerce GappTableMap,
    from Str,
    via { 'Gapp::TableMap'->new( string => $_ ) };

# GappTreeViewColumn
class_type GappTreeViewColumn,
    { class => 'Gapp::TreeViewColumn' };

coerce GappTreeViewColumn,
    from HashRef,
    via { 'Gapp::TreeViewColumn'->new( %$_ ) };
    
coerce GappTreeViewColumn,
    from ArrayRef,
    via {
        my $input = $_;
        my %args;
        $args{name} = $input->[0] if defined $input->[0];
        $args{title} = $input->[1] if defined $input->[1];
        $args{renderer} = $input->[2] || 'text';
        $args{data_column} = $input->[3];
        
        # determine how to display the content
        if ( defined $input->[4] ) {
            $args{data_func} = $input->[4];
        }
        
        %args = (%args, %{ $input->[5] }) if defined $input->[5];
        return 'Gapp::TreeViewColumn'->new( %args );
    };

# GappUIManager
class_type GappUIManager,
    { class => 'Gapp::UIManager' };

coerce GappUIManager,
    from HashRef,
    via { 'Gapp::UIManager'->new( %$_ ) };

# GappWidget
class_type GappWidget,
    { class => 'Gapp::Widget' };


1;
