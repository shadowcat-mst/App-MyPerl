package App::MyPerl::Rewrite;

use Moo;
use IO::All;

extends 'App::MyPerl';

has file_preamble => (is => 'lazy', builder => sub {
  join "\n", @{$_[0]->preamble},
});

sub run {
  die "myperl-rewrite dir1 dir2 ..." unless @ARGV;
  $_[0]->rewrite_dir($_) for @ARGV;
}

sub rewrite_dir {
  my ($self, $dir) = @_;
  my $preamble = $self->file_preamble;
  foreach my $file (io->dir($dir)->all_files(0)) {
    next unless $file->name =~ /\.pm$|\.t$|^${dir}\/bin\//;
    my $data = $file->all;
    my $shebang = '';
    my $line = 1;
    if ($data =~ s/\A(#!.*\n)//) {
      $shebang = $1;
      $line = 2;
    }
    $file->print($shebang.$preamble."\n#line ${line}\n".$data);
  }
}

1;
