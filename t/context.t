use strict;
use warnings;

use Test::More tests => 3;

use Test::Sub::Deprecated;

my $expected_scalar = $Test::Sub::Deprecated::scalar;
my @expected_list = @Test::Sub::Deprecated::list;

subtest 'something' => sub {
    plan tests => 2;

    my $value = do {
        local $SIG{'__WARN__'} = sub {};
        Test::Sub::Deprecated->something();
    };
    is($value, $expected_scalar, 'returned correct value in scalar context');

    my @value = do {
        local $SIG{'__WARN__'} = sub {};
        Test::Sub::Deprecated->something();
    };
    is_deeply(\@value, \@expected_list, 'returned correct value in list context');
};

subtest 'something_deprecated' => sub {
    plan tests => 2;

    my $value = do {
        local $SIG{'__WARN__'} = sub {};
        Test::Sub::Deprecated->something_deprecated();
    };
    is($value, $expected_scalar, 'returned correct value in scalar context');

    my @value = do {
        local $SIG{'__WARN__'} = sub {};
        Test::Sub::Deprecated->something_deprecated();
    };
    is_deeply(\@value, \@expected_list, 'returned correct value in list context');
};

subtest 'something_deprecated_with_message' => sub {
    plan tests => 2;

    my $value = do {
        local $SIG{'__WARN__'} = sub {};
        Test::Sub::Deprecated->something_deprecated_with_message();
    };
    is($value, $expected_scalar, 'returned correct value in scalar context');

    my @value = do {
        local $SIG{'__WARN__'} = sub {};
        Test::Sub::Deprecated->something_deprecated_with_message();
    };
    is_deeply(\@value, \@expected_list, 'returned correct value in list context');
};
