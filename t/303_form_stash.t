#!/usr/bin/perl -w
use strict;
use warnings;

use Test::More qw( no_plan );

use Gapp;

my $map = <<ENDMAP;
+-[--------[----------+------------------------------------+
|  Label | Entry                                           |
+-[--------[----------+------------------------------------+
| Label  | ComboBox                                        |
+-[--------[----------+-[----------------------------------+
| Label  | o Radio    | o Radio                            |
+-[--------[----------+------------------------------------+
| Label  | o Check                                         |
+->------+------------+------------------------------------+
|  ButtonBox                                               |
+--------+------------+------------------------------------+
ENDMAP

my $form = Gapp::Table->new(
    traits => [qw( Form )],
    map => $map,
    stash => my $stash = Gapp::Form::Stash->new,
    content => [
        Gapp::Label->new( text => 'Entry' ),
        Gapp::Entry->new( field => 'entry' ),
        
        Gapp::Label->new( text => 'Entry' ),
        Gapp::ComboBox->new( field => 'combo', values => [ '', '1', '2', '3' ] ),
        
        Gapp::Label->new( text => 'Entry' ),
        Gapp::RadioButton->new( field => 'radio', value => 1, label => 'True' ),
        Gapp::RadioButton->new( field => 'radio', value => 0, label => 'False' ),
        
        Gapp::Label->new( text => 'Entry' ),
        Gapp::CheckButton->new( field => 'check', label => 'True' ),
        
        Gapp::VBox->new( content => [
            my $button1 = Gapp::Button->new(
                label => 'Submit',
            ),
            my $button2 = Gapp::Button->new(
                label => 'Refresh',
            ),
            my $button3 = Gapp::Button->new(
                label => 'Clear',
            ),
        ]),
        
    ]
);

use Data::Dumper;
$button1->signal_connect( clicked => sub { $form->_update_stash } );
$button2->signal_connect( clicked => sub { $form->_update_fields } );
$button3->signal_connect( clicked => sub { $form->stash->clear; $form->_update_fields; } );

#my $w = Gapp::Window->new( content => [ $form ] )->show_all;
#Gapp->main;