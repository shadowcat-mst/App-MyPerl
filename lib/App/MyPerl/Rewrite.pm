package App::MyPerl::Rewrite;

use Moo;
use IO::All;

extends 'App::MyPerl';

has file_preamble => (is => 'lazy', builder => sub {
  join "\n", @{$_[0]->preamble}, "#line 1", '';
});

sub run {
  die "myperl-rewrite dir1 dir2 ..." unless @ARGV;
  $_[0]->rewrite_dir($_) for @ARGV;
}

sub rewrite_dir {
  my ($self, $dir) = @_;
  my $preamble = $self->file_preamble;
  foreach my $file (io->dir($dir)->all_files(0)) {
    next unless $file->name =~ /\.pm$|\.t$|^bin\//;
    my $data = $file->all;
    $file->print($preamble.$data);
  }
}

1;
