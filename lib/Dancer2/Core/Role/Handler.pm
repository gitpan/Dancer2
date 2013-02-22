# ABSTRACT: TODO

package Dancer2::Core::Role::Handler;
{
  $Dancer2::Core::Role::Handler::VERSION = '0.01';
}
use Moo::Role;
use Dancer2::Core::Types;

requires 'register';

has app => (
    is  => 'ro',
    isa => InstanceOf ['Dancer2::Core::App'],
);

1;

__END__
=pod

=head1 NAME

Dancer2::Core::Role::Handler - TODO

=head1 VERSION

version 0.01

=head1 AUTHOR

Dancer Core Developers

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Alexis Sukrieh.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

