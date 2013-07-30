# ABSTRACT: Instantiate components by type and name

package Dancer2::Core::Factory;
{
    $Dancer2::Core::Factory::VERSION = '0.06';
}
use strict;
use warnings;

use Dancer2::ModuleLoader;
use Carp 'croak';

sub create {
    my ( $class, $type, $name, %options ) = @_;

    $type = _camelize($type);
    $name = _camelize($name);
    my $component_class = "Dancer2::${type}::${name}";

    my ( $ok, $error ) = Dancer2::ModuleLoader->require($component_class);
    if ( !$ok ) {
        croak "Unable to load class for $type component $name: $error";
    }

    return $component_class->new(%options);
}

sub _camelize {
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

Dancer2::Core::Factory - Instantiate components by type and name

=head1 VERSION

version 0.06

=head1 AUTHOR

Dancer Core Developers

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Alexis Sukrieh.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
