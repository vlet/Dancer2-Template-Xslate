use inc::Module::Install;

name 'Dancer-Template-Xslate';
all_from 'lib/Dancer/Template/Xslate.pm';

requires 'Dancer' => 2.00;
requires 'Moo';
requires 'Text::Xslate';
requires 'Carp';

test_requires 'Test::More';

WriteAll;
