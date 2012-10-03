package Gapp::AssistantPage;

use Moose;
use MooseX::LazyRequire;
use MooseX::SemiAffordanceAccessor;

extends 'Gapp::VBox';
with 'Gapp::Meta::Widget::Native::Trait::AssistantPage';


1;