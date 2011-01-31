package Gapp::Meta::Attribute::Trait::GtkTreeView;
use Moose::Role;

use Gapp::Types qw( MetaTreeViewColumn );
use MooseX::Types::Moose qw( ArrayRef Object Str );

use Gapp::Meta::TreeViewColumn;

has 'columns' => (
    is => 'ro',
    isa => ArrayRef,
    default => sub { [ ] },
);



before '_process_options' => sub {
    my $class   = shift;
    my $name    = shift;
    my $options = shift;
    
    $options->{class} = 'Gtk2::TreeView' if ! exists $options->{class};

    # if columns were set, coerce them if necessary
    if ( exists $options->{columns} ) {
        
        my @columns;
        for my $c ( @{$options->{columns}} ) {
            $c = to_MetaTreeViewColumn( $c ) if ! is_MetaTreeViewColumn( $c );
            push @columns, $c if $c;
        }
        
        $options->{columns} = \@columns;
    }
    
    # if columns were set, add them to the treeview upon creation
    unshift @{ $options->{build} }, sub {
        
        my ( $self, $w ) = @_;
        
        if ( $options->{columns} ) {
            
            for my $c ( @{ $options->{columns} } ) {
                
                $w->append_column( $c->gtk_widget );
                
            }
            
        }
    };
};




package Moose::Meta::Attribute::Custom::Trait::GtkTreeView;
sub register_implementation { 'Gapp::Meta::Attribute::Trait::GtkTreeView' };

1;
