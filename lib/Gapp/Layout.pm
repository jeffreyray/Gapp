package Gapp::Layout;
use strict;
use warnings;

use Gapp::Layout::Object;

use Sub::Exporter -setup => {
    exports => [qw/Layout build add to extends/],
    groups  => { default => [qw/Layout build add to extends/] },
};

{
    my %Layouts;

    sub Layout {
        my $caller = shift;
        return $Layouts{$caller} ||= Gapp::Layout::Object->new;
    }
}

sub extends {
    my ( $base ) = @_;
    caller()->Layout->set_parent( $base->Layout );
}

sub build {
    my ( $type, $definition ) = @_;
    caller()->Layout->add_builder( $type => $definition );
}

sub add {
    my ( $widget, @args ) = @_;
    caller()->Layout->add_packer( $widget, @args );
}

sub to {
    my ( $container, @args ) = @_;
    return ( $container, @args );
}


1;

