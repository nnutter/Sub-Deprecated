package Test::Sub::Deprecated;
use base qw(Sub::Deprecated);
use vars qw($version $message);

$version = 1.0.5;
$message = 'Use something not deprecated instead.';

sub something {
    return 1;
}

sub something_deprecated : Deprecated($version) {
    return 1;
}

sub something_deprecated_with_message : Deprecated($version, $message) {
    return 1;
}
