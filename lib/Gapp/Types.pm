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

coerce MetaTreeViewColumn,
    from ArrayRef,
    via {
        my $input = $_;
        my %args;
        $args{label} = $input->[0] if defined $input->[0];
        
        # determine how to display the content
        if ( defined $input->[1] ) {
            
            if ( is_Int( $input->[1] ) ) {
                $args{data_column} = $input->[1];
            }
            elsif ( is_Str( $input->[1] ) || is_CodeRef( $input->[1] ) ) {
                $args{data_column} = 0;
                $args{display} = $input->[1];
            }
            
        }
        
        %args = (%args, %{ $input->[2] }) if defined $input->[2];
        return 'Gapp::Meta::TreeViewColumn'->new( %args );
    };

1;
