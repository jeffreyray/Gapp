package Gapp::Actions;

use Moose;
use namespace::clean -except => [qw( meta )];

use Gapp::Actions::Base;
use base qw( Exporter );
our @EXPORT_OK = qw( action );

#do_New( $storm, $widget, @args );

sub import {
    my ($class, %args) = @_;

    my  $callee = caller;
    strict->import;
    warnings->import;

    # inject base class into new library
    {   no strict 'refs';
        unshift @{ $callee . '::ISA' }, 'Gapp::Actions::Base';
    }
    
    my @declare = @{ $args{ -declare } || [] };
    $callee->import( @declare );
    __PACKAGE__->export_to_level(1, $class, 'action');
    1;
}

sub action {   
    my $class = caller();
    my ( $name, @args ) = @_;
    $class->Action->add_action( $name, { @args } );
}


1;











#package Gapp::Actions;
#use strict;
#use warnings;
#
#use Gapp::Meta::ActionSet;
#
#use Sub::Name;
#use namespace::clean -except => [qw( meta )];
#
#
#
#
#use Sub::Exporter -setup => {
#    exports => [qw/Action action perform/],
#    groups  => { default => [qw/Action action perform/] },
#};
#
#{
#    my %Actions;
#
#    sub Action {
#        my $caller = shift;
#        return $Actions{$caller} ||= Gapp::Meta::ActionSet->new;
#    }
#}
#
#sub action {
#    my $class = caller();
#    my ( $name, @args ) = @_;
#    $class->Action->add_action( $name, { @args } );
#}
#
#
#sub perform {
#    my $class = shift;
#    $class->Action->perform( @_ );
#}
#
#1;
#


