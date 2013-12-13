use strict;
use warnings;

package Sub::Deprecated;

use Attribute::Handlers;

sub Deprecated : ATTR {
    my ($package, $symbol, $referent, $attr, $data, $phase, $file, $line) = @_;

    my $die = sub {
        die sprintf('%s at %s line %d.', $_[0], $file, $line);
    };

    if (! defined $data || scalar(@$data) > 2) {
        $die->('ERROR: Invalid use of Deprecated(version, [message]) attribute.');
    }

    if ($symbol eq 'ANON') {
        $die->('ERROR: Deprecated attribute does not work on anonymous subroutines.');
    }

    my $name = *{$symbol}{NAME};
    my ($deprecated_version, $message) = @{$data};

    no warnings 'redefine';
    *{$symbol} = sub {
        my $warning = sprintf(
            'WARNING: %s::%s deprecated as of v%vd.',
            $package, $name, $deprecated_version,
        );
        if (defined $message && $message) {
            chomp $message;
            $warning .= '  ' . $message;
        }
        warn $warning, "\n";
        goto &$referent;
    };
}

1;

__END__

=pod

=head1 NAME

Sub::Deprecated - Warn when deprecated subroutines are used

=head1 SYNOPSIS

Add the C<:Deprecated> attribute to a subroutine to automatically produce a warning
when used.

    sub old_method : Deprecated(v1.4) {
        ...
    }

    sub older_method : Deprecated(v1.4, 'Use new_method instead.') {
        ...
    }

=head1 DESCRIPTION

Provides a C<:Deprecated> attribute for subroutines that can be used to
decorate deprecated subroutines.  The decorator produces a warning using the
supplied version string and optional message.

=head1 SEE ALSO

Inspired by L<Sub::Private|Sub::Private> which provides a C<:Private> attribute
for subroutines.

=head1 AUTHOR

Nathaniel G. Nutter <nnutter@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Nathaniel G. Nutter.

This is free software; you can redistribute it and/or modify it under the same
terms as the Perl 5 programming language system itself.

=cut
