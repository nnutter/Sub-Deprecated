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
        $referent->();
    };

    reinstall_sub({
        into => $package,
        as   => $name,
        code => $replacement_sub,
    });
}

1;
