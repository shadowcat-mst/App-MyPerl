use strict;
use warnings FATAL => 'all';
use Test::More qw(no_plan);
use IO::All;
use App::MyPerl;

my $my_perl = App::MyPerl->new(config_dir => io->dir('t/root'));

is_deeply(
  $my_perl->perl_options,
  [ '-Mlib::with::preamble=use strict; use warnings qw(FATAL all);,lib,t/lib',
    '-Mstrict', '-Mwarnings=FATAL,all' ],
  'Options ok'
);
