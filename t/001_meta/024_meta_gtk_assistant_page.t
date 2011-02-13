use Test::More tests => 4;
use warnings;
use strict;



use_ok 'Gapp::Meta::GtkAssistantPage';

my $o = Gapp::Meta::GtkAssistantPage->new( title => 'welcome' );
ok $o, 'created page';
is $o->title, 'welcome', 'set title';

my $w = $o->gtk_widget;
ok $w, 'created gtk widget';

1;
