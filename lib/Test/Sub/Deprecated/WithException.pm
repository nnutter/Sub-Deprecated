package Test::Sub::Deprecated::WithException;
use base qw(Sub::Deprecated);

sub invalid : Deprecated {
    return 1;
}

1;
