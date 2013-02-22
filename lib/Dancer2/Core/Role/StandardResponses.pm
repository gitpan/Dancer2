# ABSTRACT: TODO

package Dancer2::Core::Role::StandardResponses;
{
  $Dancer2::Core::Role::StandardResponses::VERSION = '0.01';
}
use Moo::Role;

sub response {
    my ($self, $ctx, $code, $message) = @_;
    $ctx->response->status($code);
    $ctx->response->header('Content-Type', 'text/plain');
    return $message;
}

sub response_400 {
    my ($self, $ctx) = @_;
    $self->response($ctx, 400, 'Bad Request');
}

sub response_404 {
    my ($self, $ctx) = @_;
    $self->response($ctx, 404, 'Not Found');
}

sub response_403 {
    my ($self, $ctx) = @_;
    $self->response($ctx, 403, 'Unauthorized');
}

1;

__END__
=pod

=head1 NAME

Dancer2::Core::Role::StandardResponses - TODO

=head1 VERSION

version 0.01

=head1 AUTHOR

Dancer Core Developers

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Alexis Sukrieh.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

