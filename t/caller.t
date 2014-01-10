use strict;
use warnings;

use Test::More tests => 3;

use File::Basename qw(dirname);
use File::Spec qw();

use lib File::Spec->join(dirname(__FILE__), 'lib');
use Test::Sub::Deprecated;

my ($package, $filename, $line) = do {
    local $SIG{'__WARN__'} = sub {};
    Test::Sub::Deprecated->caller();
};
is($package, 'main', 'found this package');
is($filename, __FILE__, 'found this file');
is($line, (__LINE__ - 4), 'found this line');
