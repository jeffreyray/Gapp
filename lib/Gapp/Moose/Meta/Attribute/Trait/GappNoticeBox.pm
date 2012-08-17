package Gapp::Moose::Meta::Attribute::Trait::GappNoticeBox;
use Moose::Role;

use MooseX::Types::Moose qw( ArrayRef HashRef );

before '_process_options' => sub {
    my ( $class, $name, $opts ) = @_;
    $opts->{gclass} = 'Gapp::NoticeBox' if ! exists $opts->{class};
    
    my @handles = qw( display hide );

    if ( is_ArrayRef( $opts->{handles} ) ) {
        push @{ $opts->{handles} }, @handles;
    }
    elsif ( is_HashRef( $opts->{handles} ) ) {
        map { $opts->{handles}{$_} = $_ } @handles;
    }
    else {
        $opts->{handles} = [\@handles];
    }


};

package Moose::Meta::Attribute::Custom::Trait::GappNoticeBox;
sub register_implementation { 'Gapp::Moose::Meta::Attribute::Trait::GappNoticeBox' };
1;
