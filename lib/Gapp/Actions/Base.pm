package Gapp::Actions::Base;

use Moose;
use Sub::Exporter qw( build_exporter );
use namespace::clean -except => [qw( meta )];

use Gapp::Meta::ActionSet;

sub import {
    my ($class, @args) = @_;
    my $callee = caller;
    
    my  @actions = $class->Action->action_list;
    print $callee, '-', @actions, "\n";
    
    my @exports;
    for my $name ( @actions ) {
        push @exports, 
            $name,
            sub { 
                print "Return $name", "\n";
                return $name;
            };
    }
    
    my $exporter = build_exporter { exports => \@exports };
    return $class->$exporter( @exports );
}

{
    my %Actions;

    sub Action {
        my $caller = shift;
        return $Actions{$caller} ||= Gapp::Meta::ActionSet->new;
    }
}

sub perform {
    my $class = shift;
    $class->Action->perform( @_ );
}

sub retrieve {
    my $class = shift;
    $class->Action->action( @_ );
}


1;
