# ABSTRACT: Core libraries for Dancer2 2.0

package Dancer2::Core;
{
    $Dancer2::Core::VERSION = '0.09';
}

use strict;
use warnings;


sub debug {
    return unless $ENV{DANCER_DEBUG_CORE};

    my $msg = shift;
    my (@stuff) = @_;

    my $vars = @stuff ? Dumper( \@stuff ) : '';

    my ( $package, $filename, $line ) = caller;

    chomp $msg;
    print STDERR "core: $msg\n$vars";
}


sub camelize {
    my ($value) = @_;

    my $camelized = '';
    for my $word ( split /_/, $value ) {
        $camelized .= ucfirst($word);
    }
    return $camelized;
}


1;

__END__

=pod

=head1 NAME

Dancer2::Core - Core libraries for Dancer2 2.0

=head1 VERSION

version 0.09

=head1 FUNCTIONS

=head2 debug

Output a message to STDERR and take further arguments as some data structures using 
L<Data::Dumper>

=head2 camelize

Camelize a underscore-separated-string.

=head1 AUTHOR

Dancer Core Developers

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Alexis Sukrieh.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
