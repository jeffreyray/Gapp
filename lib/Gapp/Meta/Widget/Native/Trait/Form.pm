package Gapp::Meta::Widget::Native::Trait::Form;

use Moose::Role;
use Gapp::Form::Stash;
use Gapp::Types qw( FormContext FormField FormStash );
with 'Gapp::Meta::Widget::Native::Trait::FormElement';


has 'context' => (
    is => 'rw',
    isa => FormContext,
);

has 'stash' => (
    is => 'rw',
    isa => FormStash,
    #trigger => \&_initialize_stash,
    #initializer => \&_initialize_stash,
    lazy_build => 1,
);

has 'sync' => (
    is => 'rw',
    isa => 'Bool',
    default => 1,
);

sub _build_stash {
    my $self = shift;
    my $stash = Gapp::Form::Stash->new;
    
    for my $w ( $self->find_fields ) {
        $stash->store( $w->field, undef ) if ! $stash->contains( $w->field );
    }
    
    $stash->set_modified( 0 );
    return $stash;
}


sub close {
    my ( $self ) = @_;
    $self->gtk_widget->destroy;
}

sub do_before_close {
    
}

sub do_after_close {
    
}

# update the user variables
sub apply {
    my ( $self ) = @_;
    $self->update_stash;
    $self->context->update_from_stash( $self->stash ) if $self->context;
}

sub ok {
    my ( $self ) = @_;
    $self->apply;
    $self->close;
}

sub do_before_ok {
    
}

sub do_after_ok {
    
}

sub cancel {
    my ( $self ) = @_;
    $self->close;
}

sub do_before_cancel {
    
}

sub do_after_cancel {
    
}


# update the values in the form
sub update {
    my ( $self ) = ( @_ );
    $self->update_fields;
}

sub find_fields {
     my ( $self ) = ( @ _ );
    
    my @fields;
    for my $w ( $self->find_descendants ) {
        push @fields, $w if is_FormField( $w );
    }
    
    return @fields;
}

sub _initialize_stash {
    my ( $self ) = @_;
    
    my $stash = $self->stash;
    
    for my $w ( $self->find_fields ) {
        $stash->store( $w->field, undef ) if ! $stash->contains( $w->field );
    }
    
    $stash->set_modified( 0 );
}

sub update_stash {
    my ( $self ) = @_;
    
    my $stash = $self->stash;
    
    for my $w ( $self->find_fields ) {
        $w->widget_to_stash( $stash );
    }
}

sub update_fields {
    my ( $self ) = @_;
    
    for my $w ( $self->find_fields ) {
        $w->set_is_updating( 1 );
        $w->stash_to_widget( $self->stash );
        $w->set_is_updating( 0 );
    }
}


package Gapp::Meta::Widget::Custom::Trait::Form;
sub register_implementation { 'Gapp::Meta::Widget::Native::Trait::Form' };


1;