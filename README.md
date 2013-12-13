# NAME

Sub::Deprecated - Warn when deprecated subroutines are used

# VERSION

version 0.003001

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

# SEE ALSO

Inspired by [Sub::Private](https://metacpan.org/pod/Sub::Private) which provides a `:Private` attribute
for subroutines.

# AUTHOR

Nathaniel G. Nutter <nnutter@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Nathaniel G. Nutter.

This is free software; you can redistribute it and/or modify it under the same
terms as the Perl 5 programming language system itself.
