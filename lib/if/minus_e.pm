package if::minus_e;

use strict;
use warnings FATAL => 'all';

sub import {
    return unless $0 eq '-e';
    shift;
    my ($target, @args) = @_;
    require Module::Runtime;
    my $import = Module::Runtime::use_module($target)->can('import');
    goto &$import if $import;
}

1;
