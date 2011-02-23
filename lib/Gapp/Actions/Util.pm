package Gapp::Actions::Util;

use Carp ();
use List::MoreUtils qw( all any );
use Scalar::Util qw( blessed reftype );
use Moose::Exporter;
use Scalar::Util 'blessed';

use Gapp::Action;
use Gapp::Action::Registry;

Moose::Exporter->setup_import_methods(
    with_caller => [
        qw( action ),
    ],
    as_is => [
        qw( ACTION_REGISTRY ),
    ]
);

{
    my %REGISTRY;

    sub ACTION_REGISTRY {
        my $class = shift;
        return $REGISTRY{$class} ||= Gapp::Action::Registry->new;
    }
}

sub action {
    
    my ( $caller, $name ) = ( shift, shift );
    $name = $name->name if ref $name;
    
    my %p = ref $_[0] eq 'HASH' ? %{$_[0]} : @_;
    
    my $action = Gapp::Action->new( name => $name, %p );   
    ACTION_REGISTRY( $caller )->add_action( $action );

    return 1;

}

1;
