package Gapp::Actions;
use strict;
use warnings;

use Gapp::Meta::ActionSet;

use Sub::Exporter -setup => {
    exports => [qw/Action action perform/],
    groups  => { default => [qw/Action action perform/] },
};

{
    my %Actions;

    sub Action {
        my $caller = shift;
        return $Actions{$caller} ||= Gapp::Meta::ActionSet->new;
    }
}

sub action {
    my $class = caller();
    my ( $name, @args ) = @_;
    $class->Action->add_action( $name, { @args } );
}


sub perform {
    my $class = shift;
    $class->Action->perform( @_ );
}

1;



