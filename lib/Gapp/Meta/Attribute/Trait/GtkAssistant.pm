package Gapp::Meta::Attribute::Trait::GtkAssistant;
use Moose::Role;

use Gapp::Types qw( MetaGtkAssistantPage );
use MooseX::Types::Moose qw( ArrayRef Str Undef );

has 'pages' => (
    is => 'rw',
    isa => ArrayRef,
    default => sub { [ ] },
);

has 'icon' => (
    is => 'rw',
    isa => Str|Undef,
);

before '_process_options' => sub {
    my $class   = shift;
    my $name    = shift;
    my $options = shift;
    
    $options->{class} = 'Gtk2::Assistant' if ! exists $options->{class};
    
    # if pages were set, coerce them if necessary
    if ( exists $options->{pages} ) {
        
        my @pages;
        for my $p ( @{$options->{pages}} ) {
            $p = to_MetaGtkAssistantPage( $p ) if ! is_MetaGtkAssistantPage( $p );
            push @pages, $p if $p;
        }
        
        $options->{pages} = \@pages;
    }
    
    # if pages were set, add them to the assistant upon creation
    unshift @{ $options->{build} }, sub {
        
        my ( $self, $w ) = @_;
        
        $w->set_icon( $w->render_icon( $options->{icon}, 'dnd' ) ) if exists $options->{icon};
        
        if ( $options->{pages} ) {
            
            for my $p ( @{ $options->{pages} } ) {
                $p->append_to( $self, $w );
                
            }
            
        }
    };    
    
    
    unshift @{ $options->{build} }, sub {
        my ( $self, $w ) = @_;
        
    };
    
};


package Moose::Meta::Attribute::Custom::Trait::GtkAssistant;
sub register_implementation { 'Gapp::Meta::Attribute::Trait::GtkAssistant' };

1;
