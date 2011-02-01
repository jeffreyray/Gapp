package Gapp::Types;

use MooseX::Types -declare => [qw(
MetaTreeViewColumn
)];

use MooseX::Types::Moose qw( ArrayRef HashRef Int );

class_type MetaTreeViewColumn,
    { class => 'Gapp::Meta::TreeViewColumn' };

coerce MetaTreeViewColumn,
    from HashRef,
    via { 'Gapp::Meta::TreeViewColumn'->new( %$_ ) };
{
    my %RENDERER = (
        'text'   => [ 'Gtk2::CellRendererText', 'text' ],
        'markup' => [ 'Gtk2::CellRendererText', 'markup' ],
        'toggle' => [ 'Gtk2::CellRendererToggle', 'active' ],
    );
        
    coerce MetaTreeViewColumn,
        from ArrayRef,
        via {
            my $input = $_;
            my %args;
            $args{label} = $input->[1] if defined $input->[1];
            
            my $renderer = $input->[2];
            $args{renderer_class} = $RENDERER{ $renderer }[0];
            $args{property} = $RENDERER{ $renderer }[1];
            
            $args{data_column} = $input->[3];
            
            # determine how to display the content
            if ( defined $input->[4] ) {
                $args{display} = $input->[4];
            }
            
            %args = (%args, %{ $input->[5] }) if defined $input->[5];
            return 'Gapp::Meta::TreeViewColumn'->new( %args );
        };
}

1;
