package Gapp::ToolButton;

use Moose;
use MooseX::SemiAffordanceAccessor;
extends 'Gapp::ToolItem';

has '+class' => (
    default => 'Gtk2::ToolButton',
);

has 'stock_id' => (
    is => 'rw',
    isa => 'Str',
);

has 'icon' => (
    is => 'rw',
    isa => 'Str',
);

has 'label' => (
    is => 'rw',
    isa => 'Str',
);

sub BUILDARGS {
    my $class = shift;
    my %args = @_ == 1 && is_HashRef( $_[0] ) ? %{$_[0]} : @_;
    
    $args{label} = $args{action}->label if $args{action} && ! exists $args{label};
    $args{icon} = $args{action}->icon if $args{action} && ! exists $args{icon};
    
    if ( exists $args{stock_id} ) {
        $args{constructor} = 'new_from_stock';
        $args{args} = [ $args{stock_id} ];
    }
    else {
        if ( ! $args{icon} ) {
            warn 'must set icon or stock_id';
        }
        else {
            $args{args} = [
                Gtk2::Image->new_from_stock( $args{icon} , 'dnd' ),
                $args{label},
            ];
        }
    }
    
    __PACKAGE__->SUPER::BUILDARGS( %args );
}

1;
