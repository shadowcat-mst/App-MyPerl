use strictures 1;
use Test::More;
use App::MyPerl;

my $my_perl = App::MyPerl->new(project_config_dir => 't/root');

is_deeply(
  $my_perl->perl_options,
  [ '-Mlib::with::preamble=use strict; use warnings qw(FATAL all);,lib,t/lib',
    '-Mstrict', '-Mwarnings=FATAL,all' ],
  'Options ok'
);

done_testing;
