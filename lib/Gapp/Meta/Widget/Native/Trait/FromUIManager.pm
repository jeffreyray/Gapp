package Gapp::Meta::Widget::Native::Trait::FromUIManager;

use Moose::Role;
use MooseX::LazyRequire;

use Gapp::Types qw( GappUIManager );

has 'ui' => (
    is => 'rw',
    isa => GappUIManager,
    coerce => 1,
    lazy_required => 1,
);

has 'ui_widget' => (
    is => 'rw',
    isa => 'Str',
    lazy_required => 1,
);

around '_construct_gtk_widget' => sub {
    my ( $orig, $self ) = @_;
    my $w = $self->ui->gtk_widget->get_widget( $self->ui_widget );
    print $w, "\n";
    
    if ( ! $w ) {
        $self->meta->throw_error(
            q[could not find widget ] . $self->ui_widget . q[ in: ] .
            ( scalar @{ $self->ui->files } ?
            join ( ',' , @{ $self->ui->files } ) :
            '(no files in ui)' )
        )
    }
    else {
        $self->set_gtk_widget( $w );
        return $w;
    }
    
};


package Gapp::Meta::Widget::Custom::Trait::FromUIManager;
sub register_implementation { 'Gapp::Meta::Widget::Native::Trait::FromUIManager' };


1;