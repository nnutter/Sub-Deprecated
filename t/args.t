use strict;
use warnings;

use Test::More tests => 1;

use File::Basename qw(dirname);
use File::Spec qw();

use lib File::Spec->join(dirname(__FILE__), 'lib');
use Test::Sub::Deprecated;

my @expected_args = ('1', 'B', '9');
my @args = do {
    local $SIG{'__WARN__'} = sub {};
    Test::Sub::Deprecated::args_passthrough(@expected_args)
};
is_deeply(\@args, \@expected_args, 'args passed through');
