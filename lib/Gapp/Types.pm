package Gapp::Types;

use MooseX::Types -declare => [qw(
MetaTreeViewColumn
)];

use MooseX::Types::Moose qw( ArrayRef HashRef Int );

class_type MetaTreeViewColumn,
    { class => 'Gapp::Meta::TreeViewColumn' };


{

    my %RENDERER = (
        'text'   => [ 'Gtk2::CellRendererText', 'text' ],
        'markup' => [ 'Gtk2::CellRendererText', 'markup' ],
        'toggle' => [ 'Gtk2::CellRendererToggle', 'active' ],
    );

    coerce MetaTreeViewColumn,
        from HashRef,
        via {
            my %args;
            
            $_->{renderer} ||= 'text'; 
            if ( $_->{renderer} && exists $RENDERER{ $_->{renderer} } ) {
                $args{renderer_class} = $RENDERER{ $_->{renderer} }[0];
                $args{property} = $RENDERER{ $_->{renderer} }[1];
                delete $_->{renderer};
            }
            
            'Gapp::Meta::TreeViewColumn'->new( %args, %$_ )
        };
        
    coerce MetaTreeViewColumn,
        from ArrayRef,
        via {
            my $input = $_;
            my %args;
            $args{name} = $input->[0] if defined $input->[0];
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
