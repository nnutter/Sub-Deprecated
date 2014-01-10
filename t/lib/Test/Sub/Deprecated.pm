use strict;
use warnings;

package Test::Sub::Deprecated;
use base qw(Sub::Deprecated);
use vars qw($version $message $scalar @list);

BEGIN {
    $version = 1.0.5;
    $message = 'Use something not deprecated instead.';
    $scalar = 'MyScalar';
    @list = ('My', 'List');
};

sub something {
    if (wantarray) {
        return @list;
    } else {
        return $scalar;
    }
}

sub something_deprecated : Deprecated($version) {
    something();
}

sub something_deprecated_with_message : Deprecated($version, $message) {
    something();
}

sub caller : Deprecated($version) {
    return caller;
}

sub args_passthrough : Deprecated($version) {
    return @_;
}

1;
