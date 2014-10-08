package Dancer2::Core::Role::StandardResponses;
# ABSTRACT: Role to provide commonly used responses
$Dancer2::Core::Role::StandardResponses::VERSION = '0.151000';
use Moo::Role;

sub response {
    my ( $self, $app, $code, $message ) = @_;
    $app->response->status($code);
    $app->response->header( 'Content-Type', 'text/plain' );
    return $message;
}

sub response_400 {
    my ( $self, $app ) = @_;
    $self->response( $app, 400, 'Bad Request' );
}

sub response_404 {
    my ( $self, $app ) = @_;
    $self->response( $app, 404, 'Not Found' );
}

sub response_403 {
    my ( $self, $app ) = @_;
    $self->response( $app, 403, 'Unauthorized' );
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Dancer2::Core::Role::StandardResponses - Role to provide commonly used responses

=head1 VERSION

version 0.151000

=head1 METHODS

=head2 response

Generic method that produces a response given with a code and a message:

    $self->response( $app, 404, "not found" );

=head2 response_400

Produces a 400 response

=head2 response_404

Produces a 404 response

=head2 response_403

Produces a 403 response

=head1 AUTHOR

Dancer Core Developers

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by Alexis Sukrieh.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
