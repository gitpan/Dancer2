# ABSTRACT: Class for handling the AutoPage feature

package Dancer2::Handler::AutoPage;
{
    $Dancer2::Handler::AutoPage::VERSION = '0.05';
}
use Moo;
use Carp 'croak';
use Dancer2::Core::Types;

with 'Dancer2::Core::Role::Handler';
with 'Dancer2::Core::Role::StandardResponses';

sub register {
    my ( $self, $app ) = @_;

    return unless $app->config->{auto_page};

    $app->add_route(
        method => $_,
        regexp => $self->regexp,
        code   => $self->code,
    ) for $self->methods;
}

sub code {
    sub {
        my $ctx = shift;

        my $template = $ctx->app->config->{template};
        if ( !defined $template ) {
            $ctx->response->has_passed(1);
            return;
        }

        my $page      = $ctx->request->params->{'page'};
        my $view_path = $template->view($page);
        if ( !-f $view_path ) {
            $ctx->response->has_passed(1);
            return;
        }

        my $ct = $template->process($page);
        $ctx->response->header( 'Content-Length', length($ct) );
        return ( $ctx->request->method eq 'GET' ) ? $ct : '';
    };
}

sub regexp {'/:page'}

sub methods {qw(head get)}

1;


=pod

=head1 NAME

Dancer2::Handler::AutoPage - Class for handling the AutoPage feature

=head1 VERSION

version 0.05

=head1 DESCRIPTION

The AutoPage feature is a Handler (turned on by default) that is responsible
for serving pages that match an existing template. If a view exists with a name
that matches the requested path, Dancer2 processes the request using the
Autopage handler.

This allows you to easily serve simple pages without having to write a route
definition for them.

If there's no view with the name request, the route passes, allowing
other matching routes to be dispatched.

=head1 METHODS

=head2 register

Creates the routes.

=head2 code

A code reference that processes the route request.

=head2 methods

The methods that should be served for autopages.

Default: B<head>, B<get>.

=head2 regexp

The regexp (path) we want to match.

Default: B</:page>.

=head1 AUTHOR

Dancer Core Developers

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Alexis Sukrieh.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__
