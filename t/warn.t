use strict;
use warnings;

use Test::More tests => 4;

use File::Basename qw(dirname);
use File::Spec qw();

use lib File::Spec->join(dirname(__FILE__), 'lib');
use Test::Sub::Deprecated;

BEGIN {
    # Default ATTR is at CHECK phase which doesn't work when something in BEGIN
    # "copies" a method, e.g. Git::Repository::Plugin.
    *{early_something_deprecated} = \&Test::Sub::Deprecated::something_deprecated;
};

my $expected_version = $Test::Sub::Deprecated::version;
my $expected_version_re = qr/\Q$expected_version\E/;
my $expected_message_re = qr/\Q$Test::Sub::Deprecated::message\E/;

sub catch_warn(&) {
    my $code = shift;
    my $warn = '';
    local $SIG{'__WARN__'} = sub { $warn = $_[0] };
    $code->();
    return $warn;
}

subtest 'early_something_deprecated' => sub {
    plan tests => 2;
    my $warn = catch_warn { early_something_deprecated() };
    like($warn, $expected_version_re, 'does mention version');
    unlike($warn, $expected_message_re, 'does not mention message');
};

subtest 'something' => sub {
    plan tests => 2;
    my $warn = catch_warn { Test::Sub::Deprecated->something() };
    unlike($warn, $expected_version_re, 'does not mention version');
    unlike($warn, $expected_message_re, 'does not mention message');
};

subtest 'something_deprecated' => sub {
    plan tests => 2;
    my $warn = catch_warn { Test::Sub::Deprecated->something_deprecated() };
    like($warn, $expected_version_re, 'does mention version');
    unlike($warn, $expected_message_re, 'does not mention message');
};

subtest 'something_deprecated_with_message' => sub {
    plan tests => 2;
    my $warn = catch_warn { Test::Sub::Deprecated->something_deprecated_with_message() };
    like($warn, $expected_version_re, 'does mention version');
    like($warn, $expected_message_re, 'does mention message');
};

