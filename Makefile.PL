use inc::Module::Install;

name 'SeoulPM';

version_from 'lib/SeoulPM.pm';

requires 'DBD::mysql';
requires 'DBI';
requires 'DBIx::Class::InflateColumn::DateTime';
requires 'DBIx::Class::PassphraseColumn';
requires 'DBIx::Class::Schema::Loader';
requires 'DBIx::Class::TimeStamp';
requires 'File::Type';
requires 'GD';
requires 'HTML::TreeBuilder::LibXML';
requires 'Mojolicious' => '3.43';
requires 'Mojolicious::Plugin::MoreHelpers';
requires 'Moose';
requires 'Text::MultiMarkdown';

recommends 'Task::Plack';

license 'perl';

WriteAll();
