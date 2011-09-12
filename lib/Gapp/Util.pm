package Gapp::Util;

use Moose;
use Sub::Exporter;

Sub::Exporter::setup_exporter({
    exports => [qw( resolve_widget_trait_alias replace_entities)],
    groups  => { all => [qw( resolve_widget_trait_alias replace_entities )] }
});

# resolve custom widget trait names
sub _build_alias_package_name {
    my ( $type, $name, $trait ) = @_;
    return 'Gapp::Meta::'
         . $type
         . '::Custom::'
         . ( $trait ? 'Trait::' : '' )
         . $name;
}

{
    my %cache;

    sub resolve_widget_class_alias {
        my ( $type, $widget_class_name, %options ) = @_;

        my $cache_key = $type . q{ } . ( $options{trait} ? '-Trait' : '' );
        return $cache{$cache_key}{$widget_class_name}
            if $cache{$cache_key}{$widget_class_name};

        my $possible_full_name = _build_alias_package_name(
            $type, $widget_class_name, $options{trait}
        );

        my $loaded_class = Class::MOP::load_first_existing_class(
            $possible_full_name,
            $widget_class_name
        );

        return $cache{$cache_key}{$widget_class_name}
            = $loaded_class->can('register_implementation')
            ? $loaded_class->register_implementation
            : $loaded_class;
    }
}


sub resolve_widget_trait_alias {
    return resolve_widget_class_alias( @_, trait => 1 );
}



# convert entities for passing to markup properties
sub replace_entities {
    my ( $str ) = @_;
    
    $str =~ s/&/&amp;/g;
    return $str;
}
1;