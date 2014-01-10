[![Build Status](https://travis-ci.org/nnutter/Sub-Deprecated.png?branch=master)](https://travis-ci.org/nnutter/Sub-Deprecated)
# NAME

Sub::Deprecated - Warn when deprecated subroutines are used

# SYNOPSIS

Add the `:Deprecated` attribute to a subroutine to automatically produce a warning
when used.

    sub old_method : Deprecated(v1.4) {
        ...
    }

    sub older_method : Deprecated(v1.4, 'Use new_method instead.') {
        ...
    }

# DESCRIPTION

Provides a `:Deprecated` attribute for subroutines that can be used to
decorate deprecated subroutines.  The decorator produces a warning using the
supplied version string and optional message.

Inspired by [Sub::Private](https://metacpan.org/pod/Sub::Private) which provides a `:Private` attribute
for subroutines.

# SEE ALSO

[Sub::Private](https://metacpan.org/pod/Sub::Private)

# AUTHOR

Nathaniel G. Nutter <nnutter@cpan.org>

# COPYRIGHT

Copyright 2013 - Nathaniel G. Nutter

# LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.
