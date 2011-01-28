package Gapp::Actions;
use Moose;

use Gapp::Actions::Base;
use Gapp::Actions::Util;
use Carp::Clan qw( ^Gapp::Actions );
use Sub::Name;

use namespace::clean -except => [qw( meta )];


sub import {
    my ($class, %args) = @_;
    my  $callee = caller;

    # everyone should want this
    strict->import;
    warnings->import;

    # inject base class into new library
    {   no strict 'refs';
        unshift @{ $callee . '::ISA' }, 'Gapp::Actions::Base';
    }

    # generate predeclared action helpers
    if (my @orig_declare = @{ $args{ -declare } || [] }) {
        my @to_export;
        
        for my $action (@orig_declare) {
            
            croak "Cannot create an action containing '::' ($action) at the moment"
                if $action =~ /::/;
            
            # add action to library and remember to export
            $callee->declare_action( $action );
            push @to_export, $action;
        }
        
        $callee->import({ -full => 1, -into => $callee }, @to_export);
    }

    Gapp::Actions::Util->import({ into => $callee });

    1;
}


sub action_export_generator {
    my ( $class, $caller, $name ) = @_;
    
    return subname "__ACTION__::" . $caller . "::" . "$name" => sub {
        return ACTION_REGISTRY( $caller )->action( $name );
    };
}

sub perform_export_generator {
    my ( $class, $caller, $name ) = @_;
    
    return sub {
        my $action = ACTION_REGISTRY( $caller )->action( $name );
        return $action->code->( $action, @_ );
    };
}
1;
