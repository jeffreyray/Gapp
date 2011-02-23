package Gapp::Moose::Meta::Attribute::Trait::GappWidget;
use Moose::Role;

has 'class' => (
    is => 'rw',
    isa => 'Str',
);

has 'construct' => (
    is => 'rw',
    isa => 'ArrayRef|CodeRef|Int|Undef',
);

has 'constructor' => (
    is => 'rw',
    isa => 'Str',
    default => 'new',
);

before '_process_options' => sub {
    my ( $class, $name, $opts ) = @_;
    
    if ( $opts->{construct} ) {
        warn 'you provided a construct argument and a default' if $opts->{default};
        warn 'you provided a construct argument and a builder' if $opts->{builder};
        
        $opts->{default} = sub {
            my ( $self ) = @_;
            my $att = $self->meta->get_attribute( $name );
            
            my $wclass = $att->class;
            my $wmethod = $att->constructor;
            
            my %opts;
            for ( $att->construct ) {
                last if is_Int( $_ ) && $_;
                %opts = %$_ and last if is_HashRef( $_ );
                %opts = ( @$_ ) and last if is_ArrayRef( $_ );
                %opts = $_->( $self ) and last if is_CodeRef( $_ );
            }
            
            my $w = $wclass->$wmethod( %opts );
            
            return $w;
        };
    }
    
};

package Moose::Meta::Attribute::Custom::Trait::GappWidget;
sub register_implementation { 'Gapp::Meta::Attribute::Trait::GappWidget' };

1;
