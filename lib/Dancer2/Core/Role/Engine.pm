# ABSTRACT: TODO

package Dancer2::Core::Role::Engine;
{
  $Dancer2::Core::Role::Engine::VERSION = '0.01';
}
use Moo::Role;
use Dancer2::Core::Types;

with 'Dancer2::Core::Role::Hookable';

has type => (
    is      => 'ro',
    lazy    => 1,
    builder => 1,
);

has environment => (is => 'ro');
has location    => (is => 'ro');

has context => (
    is        => 'rw',
    isa       => InstanceOf ['Dancer2::Core::Context'],
    clearer   => 'clear_context',
    predicate => 1,
);

has config => (
    is      => 'rw',
    isa     => HashRef,
    default => sub { {} },
);

requires '_build_type';

1;

__END__
=pod

=head1 NAME

Dancer2::Core::Role::Engine - TODO

=head1 VERSION

version 0.01

=head1 AUTHOR

Dancer Core Developers

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Alexis Sukrieh.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

