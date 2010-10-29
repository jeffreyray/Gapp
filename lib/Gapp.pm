package Gapp;

use Moose ();
use Moose::Exporter;

Moose::Exporter->setup_import_methods(
    with_meta => ['widget'],
    also      => 'Moose',
);

sub init_meta {
    shift;
    return Moose->init_meta( @_,
        # metaclass => 'MyApp::Meta::Class',
        base_class => 'Gapp::Object',
    );
}

sub widget {
    my $meta = shift;
    $meta->table(shift);
}

sub has {
    
}


1;
