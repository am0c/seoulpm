use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  NAME         => 'Mojolicious::Plugin::MoreHelpers',
  VERSION_FROM => 'lib/Mojolicious/Plugin/MoreHelpers.pm',
  AUTHOR       => 'Hojung Youn <amorette@cpan.org>',
  PREREQ_PM    => {'Mojolicious' => '3.43'},
  test         => {TESTS => 't/*.t'}
);
