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

App::MyPerl - Your very own set of perl defaults, on a per project basis

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

and through the magic of L<lib::with::preamble>, 'lib/' and 't/lib' are
already in @INC but files loaded from there will behave as if they had those
lines in them, too.

To run tests do -

  $ myprove t/foo.t

And in your Makefile.PL -

  sub MY::postamble {
    q{distdir: myperl_rewrite
  myperl_rewrite: create_distdir
  	myperl-rewrite $(DISTVNAME)
  };
  }

to have the defaults added to the top of .pm, .t and bin/* files in your dist
when it's built for CPAN.

(warning: this is make - so the indent for the myperl-rewrite line needs to
be a hard tab)

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
