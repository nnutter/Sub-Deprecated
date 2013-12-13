use strict;
use warnings;

package Sub::Deprecated;

use Attribute::Handlers;
use Sub::Install qw(reinstall_sub);

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

    my $replacement_sub = sub {
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

    reinstall_sub({
        into => $package,
        as   => $name,
        code => $replacement_sub,
    });
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

=head1 AUTHOR

Nathaniel G. Nutter <nnutter@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Ryan C. Thompson.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=head1 DISCLAIMER OF WARRANTY

BECAUSE THIS SOFTWARE IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
FOR THE SOFTWARE, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT
WHEN OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER
PARTIES PROVIDE THE SOFTWARE "AS IS" WITHOUT WARRANTY OF ANY KIND,
EITHER EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
PURPOSE. THE ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE
SOFTWARE IS WITH YOU. SHOULD THE SOFTWARE PROVE DEFECTIVE, YOU ASSUME
THE COST OF ALL NECESSARY SERVICING, REPAIR, OR CORRECTION.

IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
REDISTRIBUTE THE SOFTWARE AS PERMITTED BY THE ABOVE LICENCE, BE LIABLE
TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE THE
SOFTWARE (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING
RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A
FAILURE OF THE SOFTWARE TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF
SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH
DAMAGES.

=cut
