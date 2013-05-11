package App::MyPerl;

use Moo;
use IO::All;

our $VERSION = '0.001001';

with 'App::MyPerl::Role::Script';

sub run {
  exec($^X, @{$_[0]->perl_options}, @ARGV);
}

1;

=head1 NAME

App::MyPerl - Your very own set of perl defaults, on a global or per project basis

=head1 DESCRIPTION

A Perl program usually requires some preamble to get some defaults right

  use strict;
  use warnings;
  no indirect;
  use Try::Tiny;
  use autodie qw(:all);

On top of that you might find L<Scalar::Util>, L<List::Util> useful all over your code.

myperl allows you define this boilerplate once and for all.

=head1 TUTORIAL

if there is no export MYPERL_HOME='~./perl_defaults', '~/.myperl' is by default read

  # .myperl/always/modules
  strictures
  autodie=:all

  # .myperl/defaults/modules
  v5.14

  # script.pl
  say "hi"

Now,

  $ myperl bin/some-script

will print "hi" and it will include modules in defaults/modules and always/modules

Lets say we have a Perl project,
    lib/
    t/
    bin/
    README
    LICENSE
    Makefile.PL
    .myperl
    ...

Now,

  $ myperl bin/app.pl

will configure perl in such a way that lib/** and t/lib/** bin/** will all
have the preamble defined in $proj/.myperl/modules and ~/.myperl/always/modules
thanks to the import hooks in L<lib::with::perlude>

If you don't have a $proj/.myperl/modules, myperl will use ~/.myperl/defaults in place of it

You can configure the directory $proj/.myperl with export MYPERL_CONFIG

Running tests,

  $ myprove t/foo.t

And in your Makefile.PL -

  sub MY::postamble {
    q{distdir: myperl_rewrite
  myperl_rewrite: create_distdir
  	myperl-rewrite $(DISTVNAME)
  };
  }

(warning: this is make - so the indent for the myperl-rewrite line needs to
be a hard tab)

to have the defaults added to the top of .pm, .t and bin/* files in your dist
when it's built for CPAN.

Have fun with your-perl !

=head1 AUTHOR

mst - Matt S. Trout (cpan:MSTROUT) <mst@shadowcat.co.uk>

=head1 CONTRIBUTORS

None yet. Well volunteered? :)

=head1 COPYRIGHT

Copyright (c) 2013 the App::MyPerl L</AUTHOR> and L</CONTRIBUTORS>
as listed above.

=head1 LICENSE

This library is free software and may be distributed under the same terms
as perl itself.

=cut
