use Module::Package;
my $pack = Module::Package->new(
    name => 'Gapp',
    version_from => 'lib/Gapp.pm',
    prereq_pm => {
	'Moose' => 0,
	'MooseX::SemiAffordanceAccessor' => 0,
        'MooseX::StrictConstructor' => 0,
	'MooseX::Types' => 0,
        'Gtk2' => 0,
        'DateTime' => 0,
    },
    abstract_from => 'lib/Gapp.pm',
    author => 'Jeffrey Ray Hallock <jeffrey dot hallock at gmail dot com>',
    exclude => [ '*.komodoproject', '.komodotools', '.git' ],
);
$pack->package;


