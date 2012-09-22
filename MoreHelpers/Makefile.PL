use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  NAME         => 'Mojolicious::Plugin::MoreHelpers',
  VERSION_FROM => 'lib/Mojolicious/Plugin/MoreHelpers.pm',
  AUTHOR       => 'A Good Programmer <nospam@cpan.org>',
  PREREQ_PM    => {'Mojolicious' => '3.39'},
  test         => {TESTS => 't/*.t'}
);
