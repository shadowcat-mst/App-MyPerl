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

=head1 SYNOPSIS

  # .myperl/modules
  v5.14
  strictures
  autodie=:all

$ myperl bin/some-script

Runs some-script with the following already loaded

  use v5.14;
  use strictures;
  use autodie qw(:all);

and through the magic of L<lib::with::preamble>, C<lib/> and <t/lib> are
already in @INC but files loaded from there will behave as if they had those
lines in them, too.

It is possible to add global defaults, to all scripts and all my perl projects with C<~/.myperl/defaults/modules>
and C<~/.myperl/always/modules>

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

if there is no C<export MYPERL_HOME="~./perl_defaults">, C<~/.myperl> is by default read for global defaults

  # ~/.myperl/always/modules
  strictures
  autodie=:all

  # ~/.myperl/defaults/modules
  v5.14

  # ~/some_scripts/script.pl
  say "Hello World"

Now,

  $ myperl ~/some_scripts/script.pl

will print C<Hello World>.

Let's say you are working on a typical Perl module like,

    lib/
    t/
    bin/
    README
    LICENSE
    Makefile.PL
    .myperl
    ...

Now,

  $ cd $project_dir; myperl bin/app.pl

will configure perl in such a way that C<lib/**> and C<t/lib/**>, will all
have the preamble defined in C<.myperl/modules> and C<~/.myperl/always/modules>
thanks to the import hooks in L<lib::with::perlude>.

If you don't have a C<.myperl/modules>, myperl will use C<~/.myperl/defaults> in place of it

You can configure the directory C<$project_dir/.myperl> with C<export MYPERL_CONFIG>

Running tests,

  $ myprove t/foo.t

And in your C<Makefile.PL> -

  sub MY::postamble {
    q{distdir: myperl_rewrite
  myperl_rewrite: create_distdir
  	myperl-rewrite $(DISTVNAME)
  };
  }

(warning: this is make - so the indent for the myperl-rewrite line needs to
be a hard tab)

to have the defaults added to the top of C<.pm, .t and bin/*> files in your dist
when it's built for CPAN.

=head1 AUTHOR

mst - Matt S. Trout (cpan:MSTROUT) <mst@shadowcat.co.uk>

=head1 CONTRIBUTORS

mucker - some pod changes.

=head1 COPYRIGHT

Copyright (c) 2013 the App::MyPerl L</AUTHOR> and L</CONTRIBUTORS>
as listed above.

=head1 LICENSE

This library is free software and may be distributed under the same terms
as perl itself.

=cut
