# ABSTRACT: Basic standalone HTTP server for Dancer2

package Dancer2::Core::Server::Standalone;
{
  $Dancer2::Core::Server::Standalone::VERSION = '0.03';
}

use Moo;
use Dancer2::Core::Types;
with 'Dancer2::Core::Role::Server';
use HTTP::Server::Simple::PSGI;


sub _build_name {'Standalone'}


has backend => (
    is      => 'ro',
    isa     => InstanceOf ['HTTP::Server::Simple::PSGI'],
    lazy    => 1,
    builder => '_build_backend',
);

sub _build_backend {
    my $self    = shift;
    my $backend = HTTP::Server::Simple::PSGI->new($self->port);

    $backend->host($self->host);
    $backend->app($self->psgi_app);

    return $backend;
}


sub start {
    my $self = shift;

    $self->is_daemon
      ? $self->backend->background()
      : $self->backend->run();
}

1;

__END__
=pod

=head1 NAME

Dancer2::Core::Server::Standalone - Basic standalone HTTP server for Dancer2

=head1 VERSION

version 0.03

=head1 DESCRIPTION

This is a server implementation for a stand-alone server. It contains all the
code to start an L<HTTP::Server::Simple::PSGI> server and handle the requests.

This class consumes the role L<Dancer2::Core::Server::Standalone>.

=head1 ATTRIBUTES

=head2 backend

A L<HTTP::Server::Simple::PSGI> server.

=head1 METHODS

=head2 name

The server's name: B<Standalone>.

=head2 start

Starts the server.

=head1 AUTHOR

Dancer Core Developers

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Alexis Sukrieh.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

